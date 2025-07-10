Sure, here is an example of a simple `Dockerfile` for the SaaS you've described. This will allow you to build a Docker image that contains all of your application dependencies in one place. Note that this file assumes that your Python Flask app and PostgreSQL database are structured in a certain way:

```dockerfile
# Use an official Python runtime as the base image
FROM python:3.8-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

ENV FLASK_APP=main.py
ENV FLASK_RUN_HOST=0.0.0.0

# Run the application
CMD ["flask", "run"]
```

This `Dockerfile` does the following:

1. Starts a new build stage and sets the Base Image for subsequent instructions. Here we're using Python 3.8 as our base image.
2. Sets the working directory in the Docker container to /app. This is where your application will live inside the Docker container.
3. Copies all files from your current directory into the Docker container at /app, so it can access them.
4. Runs `pip install` with `-r requirements.txt` as an argument to install Python dependencies listed in this file.
5. Exposes port 5000 for communication with other containers. This is where your Flask app will be listening by default.
6. Sets environment variables used by the flask command. These settings tell Flask where and how to run itself.
7. Finally, it specifies that the `flask run` command should be run when a container using this image is started. This command starts your application.

This Dockerfile assumes you have a file called `requirements.txt` in the root of your project directory which lists all the Python dependencies your Flask app needs to work correctly. 

For PostgreSQL database, ensure it's running properly on the host machine and not within the Docker container itself (which is a good practice for many applications). If you need both services to run in separate containers, then you will have to manage communication between them yourself using network configuration or persistent storage options such as volumes.

Remember to replace `main.py` with your actual Flask app's entry point if it differs.

For a production environment, additional considerations should be taken, like running multiple instances of the application for scalability, configuring HTTPS, secure password handling etc. 

Also, you might want to add GitHub Actions into this setup to automate your workflow, but that's beyond the scope of Dockerfile creation.


