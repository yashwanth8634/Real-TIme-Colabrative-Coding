FROM node:20-alpine as frontend-builder

COPY ./Frontend /app

WORKDIR /app

RUN npm ci

RUN npm run build

FROM node:20-alpine as backend-builder

COPY ./Backend /app

WORKDIR /app

RUN npm ci

COPY --from=frontend-builder /app/dist /app/public

CMD ["node", "server.js"]