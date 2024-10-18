### STAGE 1: Build Angular app ###
FROM node:16 AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./

# Install missing dependencies explicitly
RUN npm install @popperjs/core --legacy-peer-deps --force

# Install other dependencies
RUN npm install --legacy-peer-deps --force

# Copy the rest of the application code
COPY . .

# Build the Angular application
RUN npm run build

### STAGE 2: Run with Nginx ###
FROM nginx:latest

# Copy the built Angular app to the Nginx html directory
COPY --from=build /app/dist/summer-workshop-angular /usr/share/nginx/html

# Copy Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
