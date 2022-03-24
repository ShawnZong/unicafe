FROM node:16-alpine as build-stage
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build

FROM node:16-alpine
WORKDIR /usr/src/app
COPY --from=build-stage /usr/src/app/build /usr/src/app/build
RUN npm install -g serve && adduser -D appuser
USER appuser
EXPOSE 3000
CMD ["serve","-s","-l","3000","build"]