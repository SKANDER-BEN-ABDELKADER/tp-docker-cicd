# Start Docker Compose services
Write-Host "Starting all services with Docker Compose..." -ForegroundColor Green
docker-compose up --build

# To run in background (detached mode), use:
# docker-compose up -d --build
