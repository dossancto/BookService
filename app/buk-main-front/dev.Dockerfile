ARG NODE_VERSION=20.17.0
FROM node:${NODE_VERSION}-slim as base

LABEL fly_launch_runtime="Next.js"

WORKDIR /app

ENV NODE_ENV="production"

FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential node-gyp pkg-config python-is-python3

COPY --link package-lock.json package.json ./

RUN npm ci --include=dev

COPY --link . .

RUN npm run build

RUN npm prune --omit=dev

FROM base

COPY --from=build /app /app

EXPOSE 3000

CMD [ "npm", "run", "start" ]
