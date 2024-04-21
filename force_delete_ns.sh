#!/usr/bin/env bash

colors=("red" "orange" "yellow" "green" "blue" "indigo" "violet" "cyan" "magenta" "pink" "brown" "black" "white" "gray")

# Function to force delete a namespace
force_delete_namespace() {
    local namespace=$1
    kubectl delete namespace $namespace --grace-period=0 --force
}

# Loop through each color namespace and force delete it
for color in "${colors[@]}"
do
    force_delete_namespace $color
done
