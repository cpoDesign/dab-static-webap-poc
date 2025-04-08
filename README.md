# DataBuilder POC with Static Web App

This project demonstrates a modern web application setup using:
- SQL Server 2022 (running in Docker)
- Data API Builder (for database API)
- Next.js (for the frontend)
- Azure Static Web App (for hosting and API integration)

## Architecture

The solution consists of several components:

1. **Database Layer**
   - SQL Server 2022 running in Docker
   - Database migrations using Grate
   - Sample database (pubs) with titles table

2. **API Layer**
   - Data API Builder providing REST and GraphQL APIs
   - Running locally for development

3. **Frontend Layer**
   - Next.js application
   - Azure Static Web App for hosting
   - API integration with Data API Builder

## Prerequisites

- Docker Desktop
- Node.js 18 or later
- Azure CLI (for Static Web App deployment)
- Data API Builder CLI

## Project Structure

```
.
├── api-dashboard/          # Next.js frontend application
├── seed-data/             # Database migration scripts
│   └── up/               # Grate migration scripts
├── Dockerfile            # SQL Server container
├── Dockerfile.migration  # Grate migration container
├── docker-compose.yml    # Container orchestration
└── dab-config.json       # Data API Builder configuration
```

## Getting Started

1. **Start the Database and Run Migrations**
   ```bash
   docker-compose up -d
   ```
   This will:
   - Start SQL Server container
   - Wait for SQL Server to be healthy
   - Run database migrations using Grate
   - Create the pubs database and tables

2. **Start the Data API Builder**
   ```bash
   cd api-dashboard
   dab start
   ```
   This will start the API server at http://localhost:5000

3. **Start the Next.js Development Server**
   ```bash
   cd api-dashboard
   npm install
   npm run dev
   ```
   The frontend will be available at http://localhost:3000

4. **Start the Static Web App Emulator**
   ```bash
   swa start http://localhost:3000
   ```
   This will start the Static Web App emulator, which will:
   - Host the Next.js application
   - Proxy API requests to Data API Builder
   - Provide authentication and authorization features

## API Endpoints

The Data API Builder exposes the following endpoints:

- REST API:
  - `GET /api/titles` - List all titles
  - `GET /api/titles/{id}` - Get a specific title
  - `POST /api/titles` - Create a new title
  - `PUT /api/titles/{id}` - Update a title
  - `DELETE /api/titles/{id}` - Delete a title

- GraphQL API:
  - Available at `/graphql`
  - Supports queries and mutations for titles

## Development Workflow

1. **Database Changes**
   - Add new migration scripts in `seed-data/up/`
   - Restart containers to apply changes:
     ```bash
     docker-compose down && docker-compose up -d
     ```

2. **API Changes**
   - Modify `dab-config.json` for API configuration
   - Restart Data API Builder:
     ```bash
     dab stop
     dab start
     ```

3. **Frontend Changes**
   - Modify Next.js components in `api-dashboard/`
   - Changes are hot-reloaded in development

## Deployment

1. **Deploy to Azure Static Web App**
   ```bash
   az staticwebapp deploy --name your-app-name --source api-dashboard
   ```

2. **Configure API Integration**
   - In Azure Portal, go to your Static Web App
   - Navigate to API configuration
   - Add the Data API Builder endpoint

## Troubleshooting

1. **Database Issues**
   - Check SQL Server logs:
     ```bash
     docker logs databuilder-poc-sqlserver-1
     ```
   - Check migration logs:
     ```bash
     docker logs databuilder-poc-db-migration-1
     ```

2. **API Issues**
   - Check Data API Builder logs
   - Verify connection string in `dab-config.json`

3. **Frontend Issues**
   - Check browser console for errors
   - Verify API endpoint configuration

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 