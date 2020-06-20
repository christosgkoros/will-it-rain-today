# client-browser build stage
FROM node:10.21.0-jessie as build-stage
RUN npm install yarn
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . ./
RUN yarn run build

# production stage
FROM meldon/willitrain
LABEL version=1.0.5
ENV VERSION 1.0.5
COPY --from=build-stage /app/dist /app/client-browser/dist
