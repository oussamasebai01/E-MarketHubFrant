### STAGE 1: Build Angular app ###
FROM node:14 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm cache clean --force
COPY . .
RUN npm install 
#--legacy-peer-deps --force
#RUN npm run build --prod

### STAGE 2: Run with Nginx ###
FROM nginx:latest AS ngi
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
