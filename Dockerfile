FROM node:14 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod
FROM nginx:alpine
COPY --from=build /app/dist/E-MarketHubFrant /usr/share/nginx/html
EXPOSE 8003
CMD ["nginx", "-g", "daemon off;"]
