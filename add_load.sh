#!/usr/bin/env bash

colors=("red" "orange" "yellow" "green" "blue" "indigo" "violet" "cyan" "magenta" "pink" "brown" "black" "white" "gray")

# Function to generate random number within a range
random_number() {
    echo $(shuf -i $1-$2 -n 1)
}

# Function to get the full domain name of a service
get_service_domain() {
    local svc=$1
    local ns=$2
    echo "$svc.$ns.svc.cluster.local"
}

# Create namespaces
for color in "${colors[@]}"
do
    kubectl create namespace $color
done

# Loop through each color namespace
for color in "${colors[@]}"
do
    # Determine the number of instances to deploy (between 5 and 20)
    num_instances=$(random_number 5 20)

    # Loop to deploy each instance with a different name
    for ((i=1; i<=$num_instances; i++))
    do
        # Generate a unique name for each instance
        app_name="color-app-$color-$i"

        # Get the full domain names for all other services
        other_svcs=""
        for svc in $(kubectl get services --namespace $color -o jsonpath="{.items[*].metadata.name}")
        do
            svc_domain=$(get_service_domain "$svc" "$color")
            other_svcs="$other_svcs,$svc_domain"
        done
        other_svcs="${other_svcs:1}" # Remove leading comma

        # Deploy the app with the background color of the namespace, a unique name, and the full domain names for all other services
        kubectl apply -n $color -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $app_name
  namespace: $color
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $app_name
  template:
    metadata:
      labels:
        app: $app_name
    spec:
      containers:
      - name: color-app
        imagePullPolicy: Always
        image: ghcr.io/busykoala/color-app:main
        ports:
        - containerPort: 3000
        env:
        - name: BG_COLOR
          value: $color
        - name: OTHER_SVCS
          value: $other_svcs
---
apiVersion: v1
kind: Service
metadata:
  name: $app_name-service
  namespace: $color
spec:
  selector:
    app: $app_name
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
EOF

    done
done
