# client-browser build stage
FROM node:9.11.1-alpine as build-stage
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

# production stage
FROM meldon/willitrain
LABEL version=1.0.5
ENV VERSION 1.0.5
COPY --from=build-stage /app/dist /app/client-browser/dist
