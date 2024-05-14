# 依存パッケージのインストール
FROM node:22.0 AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Build環境
FROM node:22.0 as builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# 実行環境
FROM node:22.0
WORKDIR /app
ENV NODE_ENV production
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nonroot:nonroot /app/.next ./.next
COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
EXPOSE 3000
ENTRYPOINT [ "node_modules/.bin/next", "start" ]