# -----------
# Build Stage
# -----------
FROM node:16-alpine

# Working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install --omit optional

# Copy the rest of the files
COPY . .

# Build the app
RUN npm run build

# Remove dev dependencies
RUN rm -rf node_modules && npm i --omit=dev --ignore-scripts

# ---------
# Run Stage
# ---------

# Copy the app from the build stage
COPY . .

# Set the environment variables
ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV
ENV PATH /app/node_modules/.bin:$PATH

# Expose the port
EXPOSE 8080

# Start the app
CMD ["npm", "start"]