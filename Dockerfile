# ----------------------------------------------------
# Stage 1: Dependencies & Build
# ----------------------------------------------------
FROM node:22-alpine AS builder

WORKDIR /app

# Install dependencies needed for compilation
COPY package*.json ./
RUN npm ci

# Copy source code and build
COPY . .
RUN npm run build

# Prune devDependencies to keep only production packages
RUN npm prune --production

# ----------------------------------------------------
# Stage 2: Minimal Production Runner
# ----------------------------------------------------
FROM node:22-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

# Upgrade OS packages to the latest Alpine security patches
RUN apk update && apk upgrade --no-cache

# Run as non-root user for security best practices
USER node

# Copy only production dependencies and build artifacts
COPY --chown=node:node --from=builder /app/package*.json ./
COPY --chown=node:node --from=builder /app/node_modules ./node_modules
COPY --chown=node:node --from=builder /app/public ./public
# For Next.js: copy the build output (adjust path if not using Next.js)
COPY --chown=node:node --from=builder /app/.next ./.next

EXPOSE 3000

# Run production server instead of dev server
CMD ["npm", "start"]
