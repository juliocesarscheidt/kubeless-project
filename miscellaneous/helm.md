# Helm Commands

```bash

curl -L 'https://github.com/juliocesarscheidt/kubeless-project/raw/main/function.zip?raw=true' --output function.zip


sha256sum function.zip | awk -F ' ' '{print $1}' | xargs -I {} sh -c "echo sha256:{}"


# install dry-run
helm upgrade --dry-run --wait \
  -i bitcoinfn \
  ./charts/bitcoinfn \
  --namespace default \
  -f ./charts/bitcoinfn/values.yaml \
  --set-string function.sha256Sum=$(sha256sum function.zip | awk -F ' ' '{print $1}')

helm ls -n default

helm uninstall bitcoinfn --namespace default

```
