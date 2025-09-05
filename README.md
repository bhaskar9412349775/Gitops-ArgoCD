# GitOps with Argo CD — Project

This project demonstrates a **GitOps workflow** using **Argo CD** on Kubernetes (K3s/Minikube). 
It auto-syncs a simple containerized Node.js app from a GitHub repo to a Kubernetes cluster.

---
This repo contains:
- `app/` a tiny Node.js app
- `manifests/` Kubernetes YAML (Deployment, Service, optional Ingress, Kustomize)
- `argo/app.yaml` an Argo CD `Application` that points to this repo
- `scripts/retag_and_push.sh` helper to build/push a new Docker tag and update manifests

---
## Prerequisites

- Linux (Ubuntu recommended)
- [Docker](https://docs.docker.com/engine/install/ubuntu/)
- [K3s](https://docs.k3s.io/quick-start) or [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Argo CD](https://argo-cd.readthedocs.io/en/stable/getting_started/)

## Verify Setup
```bash
docker --version
kubectl version --client
kubectl get nodes
```
## Quick Start (after you have K3s + Argo CD)

2) Build and push the image:
```bash
cd app
docker build -t docker.io/<bhaskar2001>/gitops-demo:v1 .
docker push docker.io/<bhaskar2001>/gitops-demo:v1
```

3) Commit and push this repo to GitHub:
```bash
git init
git add .
git commit -m "GitOps demo initial commit"
git branch -M main
git remote add origin https://github.com/<bhaskar9412349775>/gitops-argocd-sample.git
git push -u origin main
```

4) Create the Argo CD application (either via UI or kubectl):
```bash
# via kubectl
kubectl apply -f argo/app.yaml
# or via UI: use repo URL, path=manifests, target revision=main, dest namespace=demo
```

5) Verify rollout:
```bash
kubectl -n demo get all
kubectl -n demo get pods
kubectl -n demo rollout status deploy/demo-web
kubectl -n demo port-forward svc/web 9191:80
curl -s localhost:9191
```

6) Test GitOps (upgrade v1 -> v2):
```bash
./scripts/retag_and_push.sh <bhaskar2001> v2
git add manifests
git commit -m "bump to v2"
git push
# watch Argo CD sync the change
```

---

## Screenshots are available

---

# THANK YOU
