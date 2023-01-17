#!/bin/bash

# GCP vars
PROJECT_ID="smart-envoy-270916"
REGION="us-central1"
DELIVERY_PIPELINE="helloworld-app-pipeline"
PROD_TARGET="cloudrun-prod-target"
IMAGE="us-central1-docker.pkg.dev/smart-envoy-270916/my-docker-repo/helloworld"
IMAGE_NAME="helloworld-app-image"

# Create pipeline and targets
gcloud deploy apply \
  --file="./clouddeploy/clouddeploy.yaml" \
  --project=$PROJECT_ID \
  --region=$REGION

# Create release and rollout to dev
gcloud deploy releases create release-$(git rev-parse --short HEAD) \
  --project=$PROJECT_ID \
  --region=$REGION \
  --delivery-pipeline=$DELIVERY_PIPELINE \
  --images="$IMAGE_NAME=$IMAGE:$(git rev-parse --short HEAD)" \
  --skaffold-file="./clouddeploy/skaffold.yaml"

# Promote release to prod
gcloud deploy releases promote \
  --release=release-$(git rev-parse --short HEAD) \
  --delivery-pipeline=$DELIVERY_PIPELINE \
  --project=$PROJECT_ID \
  --region=$REGION \
  --to-target=$PROD_TARGET
