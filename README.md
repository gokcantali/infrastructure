# Bachelor thesis infrastructure

## Set up

Configure the master node VM similar to the below config
in `~/.ssh/config`, replacing `<PUBLIC_IP_MASTER>` and `<SSH_KEY_LOCATION>` with what you personally
have in your system.

```bash
Host                    pileus
  Hostname              <PUBLIC_IP_MASTER>
  User                  ubuntu
  IdentityFile          <SSH_KEY_LOCATION>
```

Make sure you have `helm`, `helmfile`, `kubectl` and the required
`helm-diff` helm plugin installed on your machine.
Then set up k3s and the cluster infrastructure with the below scripts.

```bash
# install the k3s master node (without flannel)
./install-master.sh <PUBLIC_IP_MASTER>

# (Optional) install k3s worker nodes by providing
# the Public IP of master node as the first argument
# and the internal IPs of all the worker nodes as following arguments
./install-nodes.sh <PUBLIC_IP_MASTER> <INTERNAL_IP_WORKER_1> <INTERNAL_IP_WORKER_2> <INTERNAL_IP_WORKER_3> ... 

# copy the kubeconfig to your host
export KUBECONFIG="$PWD/config"

# install the necessary charts
# (cert-manager, cilium, open-telemetry, backend)
helmfile apply -l base=true
```


## Prepare attack scenario

```bash
# create different namespaces
./add_load.sh

# install the attack scenario
helmfile apply -l attack=true

# setup the specific attack
helmfile apply -l [ scan=true | dos=true ]

# destroy all the attack scenario
helmfile destroy -l attack=true -l scan=true -l dos=true
```

Before destroying the generated data can be downloaded from:

```
http://<PUBLIC_IP_MASTER>/traces.zip
```
