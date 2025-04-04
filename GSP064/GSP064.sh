#!/bin/bash

# Before using the script please complete the commands below :
# export BUCKET_NAME=
# export USERNAME2=

if [ -z "$BUCKET_NAME" ] || [ -z "$USERNAME2" ] ; then
  echo "Error: One or more variables are empty or undefined."
  exit 1
fi

gcloud storage buckets create gs://$BUCKET_NAME --project=$DEVSHELL_PROJECT_ID --location=EU

echo "Do you really read script ???" > sample.txt

gsutil cp sample.txt gs://$BUCKET_NAME

gcloud projects remove-iam-policy-binding $DEVSHELL_PROJECT_ID --member=user:$USERNAME2 --role='roles/viewer'

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member=user:$USERNAME2 --role='roles/storage.objectViewer'