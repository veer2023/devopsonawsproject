# Use official Nginx image from Docker Hub
FROM nginx:alpine

# Copy your custom index.html into the default nginx public folder
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
