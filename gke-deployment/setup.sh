echo "Fetching kubeconfig for cluster..."
gcloud container clusters get-credentials "$CLUSTER" --region "$REGION" --project "$PROJECT"
