# GitOps with Argo CD — Sample Project

This repo contains:
- `app/` a tiny Node.js app
- `manifests/` Kubernetes YAML (Deployment, Service, optional Ingress, Kustomize)
- `argo/app.yaml` an Argo CD `Application` that points to this repo
- `scripts/retag_and_push.sh` helper to build/push a new Docker tag and update manifests

## Quick Start (after you have K3s + Argo CD)

1) Replace placeholders:
   - In `manifests/deployment.yaml` and `manifests/kustomization.yaml`: replace `DOCKERHUB_USERNAME`.
   - In `argo/app.yaml`: replace `USERNAME` with your GitHub username or org, and ensure the repo URL matches.

2) Build and push the image:
```bash
cd app
docker build -t docker.io/<DOCKERHUB_USERNAME>/gitops-demo:v1 .
docker push docker.io/<DOCKERHUB_USERNAME>/gitops-demo:v1
```

3) Commit and push this repo to GitHub:
```bash
git init
git add .
git commit -m "GitOps demo initial commit"
git branch -M main
git remote add origin https://github.com/<USERNAME>/gitops-argocd-sample.git
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
kubectl -n demo port-forward svc/web 8080:80
curl -s localhost:8080
```

6) Test GitOps (upgrade v1 -> v2):
```bash
./scripts/retag_and_push.sh <DOCKERHUB_USERNAME> v2
git add manifests
git commit -m "bump to v2"
git push
# watch Argo CD sync the change
```

> Optional: enable `manifests/ingress.yaml` by uncommenting it in `kustomization.yaml`, then add `127.0.0.1 app.local` to `/etc/hosts` and browse http://app.local.
