## Quick Started

- kubectl create namespace argocd
- kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

## Patch (Caso add label ao istio)

- argocd-redis.networkpolicy.patch.yaml

```console
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: argocd-redis-network-policy
spec:
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-server
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-repo-server
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-application-controller
    ports:
    - port: 6379
      protocol: TCP
  podSelector:
    matchLabels:
      app.kubernetes.io/name: argocd-redis
  policyTypes:
  - Ingress
  ```