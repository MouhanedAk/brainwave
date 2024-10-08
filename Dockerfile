# Development Dockerfile
FROM node:19.9.0

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install all dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Expose the port for the dev server
EXPOSE 5173

# Command to run the app in development mode
CMD ["npm", "run", "dev"]
