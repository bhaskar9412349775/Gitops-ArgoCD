#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <dockerhub-username> <new-tag>"
  echo "Example: $0 bhaskar v2"
  exit 1
fi

USER="$1"
TAG="$2"

# Build and push
cd "$(dirname "$0")/../app"
docker build -t "docker.io/${USER}/gitops-demo:${TAG}" .
docker push "docker.io/${USER}/gitops-demo:${TAG}"

# Update manifests
cd ../manifests
# Update image tag in kustomization (preferred)
yq -i '.images[0].newTag = strenv(TAG)' kustomization.yaml || true

# Also update Deployment image in case kustomize isn't used
sed -i "s#docker.io/.*/gitops-demo:.*#docker.io/${USER}/gitops-demo:${TAG}#g" deployment.yaml

echo "Updated manifests to tag: ${TAG}"
echo "Commit and push your repo so Argo CD syncs the change."
