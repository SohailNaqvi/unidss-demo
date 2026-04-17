#!/bin/bash
# Run this on your Mac (where gh CLI is authenticated) to publish the demo.
# Usage:  bash DEPLOY.sh
#
# This will:
#   1. Create a new public GitHub repo called "unidss-demo"
#   2. Push this folder to it
#   3. Enable GitHub Pages
#   4. Print the public URL

set -e
cd "$(dirname "$0")"

REPO_NAME="unidss-demo"

echo "Creating GitHub repo '$REPO_NAME'..."
gh repo create "$REPO_NAME" --public --source=. --remote=origin --push

echo "Enabling GitHub Pages..."
# Get the username
USER=$(gh api user --jq .login)

# Enable Pages from main branch root
gh api -X POST "repos/$USER/$REPO_NAME/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null || \
gh api -X PUT "repos/$USER/$REPO_NAME/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null || true

echo ""
echo "Done! Your demo will be live in ~1 minute at:"
echo "    https://$USER.github.io/$REPO_NAME/"
echo ""
echo "Share that link with your coworkers."
