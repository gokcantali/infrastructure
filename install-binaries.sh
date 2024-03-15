#!/usr/bin/env bash

# install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# install helmfile
helm plugin install https://github.com/databus23/helm-diff
wget https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_amd64 -O helmfile
chmod +x helmfile
mkdir ~/bin
mv helmfile ~/bin/helmfile
