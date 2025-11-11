#!/bin/bash
set -e

echo "🚀 Starting setup.sh ..."

# --- CONFIGURATION ---
PROJECT_ID=$(gcloud config get-value project)
REGION="asia-south1"
CLUSTER_NAME="${PROJECT_ID}-gke"

# --- STEP 1: Install kubectl if missing ---
if ! command -v kubectl &> /dev/null; then
  echo "🔧 Installing kubectl..."
  sudo apt-get update -y
  sudo apt-get install -y ca-certificates curl apt-transport-https gnupg
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key
  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update -y
  sudo apt-get install -y kubectl
else
  echo "✅ kubectl already installed."
fi

# --- STEP 2: Get GKE credentials ---
echo "🔑 Fetching cluster credentials..."
gcloud container clusters get-credentials "$CLUSTER_NAME" --region "$REGION" --project "$PROJECT_ID"

# --- STEP 3: Verify access ---
echo "🔍 Checking cluster connectivity..."
kubectl get nodes

# --- STEP 4: Deploy nginx test pod ---
echo "🚀 Running nginx pod..."
kubectl run test-nginx-ca --image=nginx

echo "✅ Done! Verify using: kubectl get pods"
