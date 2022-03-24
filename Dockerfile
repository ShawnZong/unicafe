FROM node:16-alpine as build-stage
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build

FROM lipanski/docker-static-website:latest
COPY --from=build-stage /usr/src/app/build /home/static/build
EXPOSE 3000
CMD ["/thttpd", "-D", "-h", "0.0.0.0", "-p", "3000", "-d", "/home/static/build", "-u", "static", "-l", "-", "-M", "60"]