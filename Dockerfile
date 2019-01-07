# client-browser build stage
FROM node:9.11.1-alpine as build-stage
WORKDIR /app
COPY client-browser/package*.json ./
RUN npm install
COPY client-browser/ .
RUN npm run build

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