#!/bin/bash

# GCP vars
PROJECT_ID="smart-envoy-270916"
SERVICE_ACCOUNT="my-service-account@smart-envoy-270916.iam.gserviceaccount.com"
REGION="global"

# GitHub vars
REPO_OWNER="javierdialpad"
BRANCH_PATTERN="^cloudbuild$"
BUILD_CONFIG_FILE="cloudbuild.yaml"

# Connecting a GitHub repository can't be automated yet (https://issuetracker.google.com/issues/142550612),
# so first follow the steps here in order to do that:
# https://cloud.google.com/build/docs/automating-builds/create-manage-triggers#connect_repo.

# Create the trigger
gcloud beta builds triggers create github \
  --name="github-trigger" \
  --region=$REGION \
  --repo-name=$(basename `git rev-parse --show-toplevel`) \
  --repo-owner=$REPO_OWNER \
  --branch-pattern=$BRANCH_PATTERN \
  --build-config=$BUILD_CONFIG_FILE \
  --include-logs-with-status \
  --service-account="projects/$PROJECT_ID/serviceAccounts/$SERVICE_ACCOUNT"
