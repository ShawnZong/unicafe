FROM node:16-alpine
COPY package* ./
RUN npm install
RUN npm install -g serve
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["serve","-s","-l","3000","build"]