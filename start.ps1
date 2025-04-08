# Check prerequisites
Write-Host "Checking prerequisites..."

# Check if Docker is running
try {
    $dockerInfo = docker info
    Write-Host "Docker is running"
} catch {
    Write-Host "Error: Docker is not running. Please start Docker Desktop first."
    exit 1
}

# Check if Data API Builder is installed
try {
    $dabVersion = dab --version
    Write-Host "Data API Builder is installed (version: $dabVersion)"
} catch {
    Write-Host "Error: Data API Builder is not installed. Please install it using: npm install -g @azure/static-web-apps-cli"
    exit 1
}

# Check if Static Web App CLI is installed
try {
    $swaVersion = swa --version
    Write-Host "Static Web App CLI is installed (version: $swaVersion)"
} catch {
    Write-Host "Error: Static Web App CLI is not installed. Please install it using: npm install -g @azure/static-web-apps-cli"
    exit 1
}

# Start Docker containers
Write-Host "Starting Docker containers..."
try {
    docker-compose up -d
    Write-Host "Docker containers started successfully"
} catch {
    Write-Host "Error: Failed to start Docker containers. Error: $_"
    exit 1
}

# Wait for SQL Server to be healthy
Write-Host "Waiting for SQL Server to be healthy..."
$maxAttempts = 30
$attempt = 1
$healthy = $false

while (-not $healthy -and $attempt -le $maxAttempts) {
    try {
        $status = docker inspect --format="{{.State.Health.Status}}" databuilder-poc-sqlserver-1
        if ($status -eq "healthy") {
            $healthy = $true
            Write-Host "SQL Server is healthy"
        } else {
            Write-Host "Waiting for SQL Server to be healthy... Attempt $attempt of $maxAttempts"
            Start-Sleep -Seconds 2
            $attempt++
        }
    } catch {
        Write-Host "Error checking SQL Server health: $_"
        Start-Sleep -Seconds 2
        $attempt++
    }
}

if (-not $healthy) {
    Write-Host "Error: SQL Server failed to become healthy within the expected time."
    Write-Host "Please check Docker logs: docker logs databuilder-poc-sqlserver-1"
    exit 1
}

# Start Data API Builder
Write-Host "Starting Data API Builder..."
try {
    Start-Process -NoNewWindow -FilePath "dab" -ArgumentList "start"
    Write-Host "Data API Builder started successfully"
} catch {
    Write-Host "Error: Failed to start Data API Builder. Error: $_"
    exit 1
}

# Wait for Data API Builder to start
Start-Sleep -Seconds 5

# Kill any existing Node.js processes
Write-Host "Cleaning up existing Node.js processes..."
Get-Process -Name node -ErrorAction SilentlyContinue | Stop-Process -Force

# Start Next.js development server
Write-Host "Starting Next.js development server..."
try {
    Set-Location api-dashboard
    if (-not (Test-Path "package.json")) {
        Write-Host "Error: package.json not found in api-dashboard directory"
        exit 1
    }
    $env:PORT = "3004"
    Start-Process -NoNewWindow -FilePath "npm" -ArgumentList "run dev"
    Write-Host "Next.js development server started successfully"
} catch {
    Write-Host "Error: Failed to start Next.js development server. Error: $_"
    exit 1
}

# Wait for Next.js to start
Start-Sleep -Seconds 5

# Start Static Web App emulator
Write-Host "Starting Static Web App emulator..."
try {
    Set-Location ..
    npx @azure/static-web-apps-cli start http://localhost:3004 --api-location http://localhost:5000
    Write-Host "Static Web App emulator started successfully"
} catch {
    Write-Host "Error: Failed to start Static Web App emulator. Error: $_"
    exit 1
}

Write-Host "`nAll services started successfully!"
Write-Host "Frontend: http://localhost:3004"
Write-Host "API: http://localhost:5000"
Write-Host "Static Web App: http://localhost:4280"
Write-Host "`nTo stop all services, run: docker-compose down" 