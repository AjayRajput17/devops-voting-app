#!/bin/bash

set -x

# Validate input arguments
if [ $# -ne 3 ]; then
  echo "Usage: $0 <service-name> <image-name> <tag>"
  exit 1
fi

SERVICE_NAME="$1"
IMAGE_NAME="$2"
TAG="$3"

# Set the repository URL
REPO_URL="https://BJZUva6NIxfVGFJ6PwZHVvdk7iKpwS3wOpWZSYeXAywfco9feNCBJQQJ99BGACAAAAA6RLJmAAASAZDO4G7w@dev.azure.com/ajayingle17/voting-app/_git/voting-app"

# Clone the git repository into the /tmp directory
TEMP_DIR="/tmp/temp_repo"
git clone "$REPO_URL" "$TEMP_DIR"

# Navigate into the cloned repository directory
cd "$TEMP_DIR" || exit 1

TARGET_FILE="k8s-specifications/${SERVICE_NAME}-deployment.yaml"

# Check if target file exists
if [ ! -f "$TARGET_FILE" ]; then
  echo "Error: File $TARGET_FILE not found!"
  exit 1
fi

echo "Before update:"
cat "$TARGET_FILE"

# Safely replace the image line
sed -i "s|\(image:\s*\).*|\1${IMAGE_NAME}:${TAG}|g" "$TARGET_FILE"

echo "After update:"
cat "$TARGET_FILE"

# Stage the changes
git add "$TARGET_FILE"

# Commit if there are any changes
if ! git diff --cached --quiet; then
  git commit -m "Update image to ${IMAGE_NAME}:${TAG} in ${SERVICE_NAME}-deployment.yaml"
  git push
else
  echo "No changes to commit."
fi

# Cleanup
rm -rf "$TEMP_DIR"
