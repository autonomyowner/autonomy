Here is an example `Dockerfile` that can be used to build and run the backend of your project:
```
FROM node:14-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Run the app
CMD ["npm", "start"]
```
This `Dockerfile` uses the official Node.js 14 image from Docker Hub as its base image. It sets the working directory to `/app`, copies the project's `package.json` and `package-lock.json` files into the image, installs dependencies with npm, copies the application code into the image, exposes port 3000 for the app to listen on, and runs the app using the command `npm start`.

You can build this Dockerfile by running the following command:
```
docker build -t <image-name> .
```
Replace `<image-name>` with a name you want to give your Docker image.

Once the image is built, you can run it using the following command:
```
docker run -p 3000:3000 <image-name>
```
This will map port 3000 on the host machine to port 3000 in the container and start the app.