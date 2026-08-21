# Dockerfile for building a Node.js application with Python 3.12-slim base image
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /apps

# Only Copy the Package installer
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 8000
 