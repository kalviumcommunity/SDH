#!/bin/bash
set -e

echo "Setting up environment-aware builds..."

# -------------------------------
# Create environment files
# -------------------------------

cat <<EOF > .env.development
# Development Environment
NEXT_PUBLIC_API_URL=http://localhost:3000/api
DATABASE_URL=postgres://dev_user:dev_pass@localhost:5432/dev_db
EOF

cat <<EOF > .env.staging
# Staging Environment
NEXT_PUBLIC_API_URL=https://staging.api.example.com
DATABASE_URL=postgres://staging_user:staging_pass@staging-db:5432/staging_db
EOF

cat <<EOF > .env.production
# Production Environment
NEXT_PUBLIC_API_URL=https://api.example.com
DATABASE_URL=postgres://prod_user:prod_pass@prod-db:5432/prod_db
EOF

cat <<EOF > .env.example
# Example Environment Variables
# Copy this file and fill in real values locally or via CI/CD

NEXT_PUBLIC_API_URL=
DATABASE_URL=
EOF

echo "Environment files created."

# -------------------------------
# Update .gitignore safely
# -------------------------------

if ! grep -q ".env*" .gitignore 2>/dev/null; then
  cat <<EOF >> .gitignore

# Environment variables
.env*
!.env.example
EOF
  echo ".gitignore updated."
else
  echo ".gitignore already contains env rules."
fi

# -------------------------------
# Update package.json scripts
# -------------------------------

if [ ! -f package.json ]; then
  echo "ERROR: package.json not found."
  exit 1
fi

node <<'EOF'
const fs = require('fs');

const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));

pkg.scripts = pkg.scripts || {};

pkg.scripts['build:development'] ||= 'cp .env.development .env && next build';
pkg.scripts['build:staging'] ||= 'cp .env.staging .env && next build';
pkg.scripts['build:production'] ||= 'cp .env.production .env && next build';

fs.writeFileSync(
  'package.json',
  JSON.stringify(pkg, null, 2)
);

console.log('package.json scripts updated.');
EOF

# -------------------------------
# Final message
# -------------------------------

echo ""
echo "Setup complete."
echo ""
echo "Available build commands:"
echo "  npm run build:development"
echo "  npm run build:staging"
echo "  npm run build:production"
echo ""
echo "IMPORTANT:"
echo "- Replace placeholder values locally or via CI/CD secrets"
echo "- Do NOT commit real secrets"
