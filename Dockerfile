# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements and source code
COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY . .

# Expose the port Flask is running on
EXPOSE 8080
# Run the app
CMD ["python", "app.py"]
