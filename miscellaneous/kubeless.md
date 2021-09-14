# Kubeless Commands

```bash

kubeless get-server-config

# python
kubeless function deploy bitcoinfn --runtime python3.7 \
                                --from-file main.py \
                                --dependencies ./requirements.txt \
                                --env CI_ENV="development" \
                                --handler main.entry


kubeless function ls -n default

kubeless function describe bitcoinfn -n default


kubectl get pod,svc,deploy -n default

kubectl get function -n default
kubectl describe function bitcoinfn -n default


kubeless function logs -f bitcoinfn


kubectl get pod -n default -l function=bitcoinfn

kubectl logs -f $(kubectl get pod -n default -l function=bitcoinfn -o custom-columns=":metadata.name" --no-headers) -n default


kubeless function call bitcoinfn --data '{"data": "PAYLOAD"}'


kubeless trigger http create bitcoinfn-http-trigger \
  --function-name bitcoinfn \
  --hostname bitcoinfn.cluster.local \
  --namespace default

# with tls-secret
kubeless trigger http create bitcoinfn-http-trigger \
  --function-name bitcoinfn \
  --hostname bitcoinfn.cluster.local \
  --namespace default
  --tls-secret secret-name


kubeless trigger http ls -n default

kubeless trigger http delete bitcoinfn-http-trigger


kubectl get ingress -n default
kubectl describe ingress -n default

kubectl logs -f $(kubectl get pods -n nginx-ingress -l app=nginx-ingress-nginx-ingress -o custom-columns=":metadata.name" --no-headers) -n nginx-ingress


INGRESS_IP=$(kubectl get svc -n nginx-ingress -l app.kubernetes.io/name=nginx-ingress-nginx-ingress --no-headers | tr -s ' ' ' ' | cut -d ' ' -f3)

echo "$INGRESS_IP bitcoinfn.cluster.local" >> /etc/hosts


curl -X POST \
  -H 'Host: bitcoinfn.cluster.local' \
  -H 'Content-Type: application/json' \
  --data '{"data": "PAYLOAD"}' \
  --url 'http://bitcoinfn.cluster.local'


# clean up
kubeless function delete bitcoinfn

```
