# Kubeless Project

This project uses Kubeless to run lambda functions inside a Kubernetes cluster.

Also it uses Helm to deploy the chart on Kubernetes.

> to deploy it, the kubeless is required to be running on cluster:
[Kubeless Quick Start](https://kubeless.io/docs/quick-start/)

## Up and Running

```bash
make build
make deploy
```

This will deploy a function on default namespace, to see the function run:

```bash
kubeless function ls -n default
```

To try out the function, run:

```bash
kubeless function call bitcoinfn -n default --data '{"data": "PAYLOAD"}'
```
