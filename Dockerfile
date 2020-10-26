# client-browser build stage
FROM node:10.21.0-jessie as build-stage
RUN npm install yarn
WORKDIR /app
COPY client-browser/package.json ./
COPY client-browser/yarn.lock ./
RUN yarn install
COPY client-browser/ ./
RUN yarn run build

# production stage
FROM trestletech/plumber as production-stage
MAINTAINER meldon <chr.goros@gmail.com>

RUN R -e "install.packages('countrycode')"

COPY --from=build-stage /app/dist /app/client-browser/dist

COPY    processed    /app/processed
COPY    start.R      /app/
COPY    plumber.R    /app/
COPY    util.R       /app/
COPY    properties.R /app/

WORKDIR /app

CMD ["plumber.R"]
