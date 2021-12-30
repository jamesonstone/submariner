# submariner

Understanding and Extending Admission Controllers

## Getting Started

This repository is the proving ground for learning about and implementing admission controllers. The [walk-through](./docs/WALKTHROUGH.md) contains my thinking process.

## Running This Demo

0. Create a kind cluster

```bash
make cluster-init
```

1. Generate TLS keys and certificates to setup the Webhook Server

```bash
make gen-keys
```

2. Add a Secret to hold the `tls.crt` and `tls.key` and add it to the manifests directory

```bash
kubectl -n submariner create secret tls webhook-server-tls \
    --cert "./keys/webhook-server-tls.crt" \
    --key "./keys/webhook-server-tls.key" \
    --dry-run=client -o yaml
```

3. Base64 encode the `ca.crt` generated in Step 2 and add it to the `mutatingwebookconfig.yaml` as the `caBundle` dynamically using make (so we don't commit the `ca.crt`)

```bash
base64 ./keys/ca.crt

webooks:
  - name: mutating-webhook-configuration
    namespace: submariner
    caBundle: "{{FILL HERE}}"
```

## Resources

- [A Guide to Kubernetes Admission Controllers](https://kubernetes.io/blog/2019/03/21/a-guide-to-kubernetes-admission-controllers/)
- [What Does Each Admission Controller Do](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#what-does-each-admission-controller-do)
- [Stackrox Demo](https://github.com/stackrox/admission-controller-webhook-demo)

## Supporting

JStone
