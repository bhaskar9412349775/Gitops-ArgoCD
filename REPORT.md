# Project Report: GitOps Workflow with Argo CD on Kubernetes

## Objective
The goal of this project was to implement a **GitOps workflow** on a Kubernetes cluster using **Argo CD**.  
With GitOps, all Kubernetes deployments are managed declaratively through version-controlled manifests stored in GitHub, ensuring **automation, auditability, and reliability**.

---

## Tools & Technologies
- **K3s** (Lightweight Kubernetes)
- **Argo CD** (GitOps Controller)
- **Docker** (Build & push application images)
- **GitHub** (Source of truth for manifests)
- **kubectl** (Kubernetes CLI)

---

## Architecture

```text
   ┌──────────────┐        ┌───────────────┐        ┌──────────────┐
   │   Developer  │  git   │   GitHub Repo │  sync  │   Argo CD    │
   │   (changes)  ├────────► (manifests)   ├────────► (GitOps Ctrl)│
   └──────────────┘        └───────────────┘        └─────┬────────┘
                                                           │
                                                           ▼
                                                   ┌──────────────┐
                                                   │ Kubernetes   │
                                                   │ (K3s Cluster)│
                                                   └──────────────┘


```

---

## Implementation Steps
```text
1. Cluster & Argo CD Setup

- Installed K3s on Ubuntu.

- Installed Argo CD in a dedicated namespace (argocd).

- Exposed Argo CD UI via port-forward.

2. Application Containerization

- Built a simple Node.js app (app/server.js).

- Created Dockerfile and pushed image to Docker Hub.

3. Kubernetes Manifests

- Wrote Deployment, Service, and optional Ingress under manifests/.

- Added kustomization.yaml for easy image tag updates.

4. GitOps Workflow

- Pushed repo to GitHub.

- Created an Argo CD Application pointing to the repo.

- Enabled auto-sync with prune + self-heal.

5. Testing GitOps

- Deployed initial version (v1) successfully.

- Updated image tag to (v2) → committed & pushed.

- Argo CD detected changes → auto-synced → cluster updated.
```

---

## Screenshots
```text
- Argo CD UI showing synced application

- kubectl get pods output with running pods

- Curl output from service (Hello from GitOps demo! Version: v2)
```

---

## Results
```text
- Achieved end-to-end GitOps workflow.

- Proved that Git is the single source of truth for deployments.

- Demonstrated continuous reconciliation and self-healing with Argo CD.
```
