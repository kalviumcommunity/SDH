#!/bin/bash
set -e

echo "Setting up Docker basics for Next.js App Router project..."

# -------------------------------
# Dockerfile
# -------------------------------
cat <<EOF > Dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

EXPOSE 3000
ENV PORT=3000

CMD ["npm", "start"]
EOF

echo "Dockerfile created."

# -------------------------------
# .dockerignore
# -------------------------------
cat <<EOF > .dockerignore
node_modules
.next
.env*
.git
.gitignore
README.md
EOF

echo ".dockerignore created."

# -------------------------------
# docker-compose.yml (optional, local use)
# -------------------------------
cat <<EOF > docker-compose.yml
version: "3.8"

services:
  web:
    build: .
    ports:
      - "3000:3000"
    env_file:
      - .env.development
EOF

echo "docker-compose.yml created."

# -------------------------------
# .env.example (if missing)
# -------------------------------
if [ ! -f .env.example ]; then
  cat <<EOF > .env.example
# Example environment variables
# Copy this file and fill values locally or via CI/CD

NEXT_PUBLIC_API_URL=
DATABASE_URL=
EOF
  echo ".env.example created."
else
  echo ".env.example already exists. Skipping."
fi

# -------------------------------
# Final output
# -------------------------------
echo ""
echo "Setup complete."
echo ""
echo "You now have:"
echo "  - Dockerfile"
echo "  - .dockerignore"
echo "  - docker-compose.yml"
echo ""
echo "Useful commands:"
echo "  docker build -t nextjs-app ."
echo "  docker run -p 3000:3000 nextjs-app"
echo "  docker-compose up"
