# Use lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy only requirements first (cache optimization)
COPY app/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY app/ .

# Expose port
EXPOSE 5000

# Run app
CMD ["python", "app.py"]