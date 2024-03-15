# Bachelor thesis infrastructure

## Set up

Configure the work VM similar to the below config
in `~/.ssh/config` assuming your ssh key is located under
`~/.ssh/bachelor.pem`.

```bash
Host                    bachelor
  Hostname              160.85.252.183
  User                  ubuntu
  IdentityFile          ~/.ssh/bachelor.pem
```

Make sure you have `helm`, `helmfile`, `kubectl` and the required
`helm-diff` helm plugin installed on your machine.
Then set up k3s and the cluster infrastructure with the below scripts.

```bash
# install the k3s master node (without flannel)
# and copy the kubeconfig to your host
./install-master.sh
export KUBECONFIG="$PWD/config"

# install the necessary charts
# (cert-manager, cilium, open-telemetry, backend)
helmfile apply

# install the open-telemetry collector for hubble
kubectl apply -f ./collector.yaml
```
