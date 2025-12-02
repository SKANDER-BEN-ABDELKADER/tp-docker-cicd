# Render Deployment Guide

This guide explains how to deploy the backend and database to Render.

## Prerequisites

1. A Render account (sign up at https://render.com)
2. This repository pushed to GitHub

## Deployment Options

### Option 1: Using render.yaml (Infrastructure as Code)

1. **Push your code to GitHub**
   ```bash
   git add .
   git commit -m "Add Render configuration"
   git push origin main
   ```

2. **Connect to Render**
   - Go to https://dashboard.render.com
   - Click "New +" → "Blueprint"
   - Connect your GitHub repository
   - Render will automatically detect the `render.yaml` file
   - Click "Apply" to deploy all services

### Option 2: Manual Deployment

#### Deploy PostgreSQL Database

1. In Render Dashboard, click "New +" → "PostgreSQL"
2. Configure:
   - **Name**: `tp-database`
   - **Database**: `mydb`
   - **User**: `postgres`
   - **Region**: Choose closest to you (e.g., Frankfurt)
   - **Plan**: Free
3. Click "Create Database"
4. Wait for provisioning to complete
5. **Copy the Internal Database URL** (you'll need this for the backend)

#### Deploy Backend Service

1. In Render Dashboard, click "New +" → "Web Service"
2. Connect your GitHub repository
3. Configure:
   - **Name**: `tp-backend`
   - **Region**: Same as database (e.g., Frankfurt)
   - **Branch**: `main` (or your branch name)
   - **Root Directory**: `backend`
   - **Environment**: `Docker`
   - **Plan**: Free
4. Add Environment Variables:
   - `PORT`: `3000`
   - `DB_HOST`: (Copy from PostgreSQL Internal URL - hostname only)
   - `DB_PORT`: `5432`
   - `DB_NAME`: `mydb`
   - `DB_USER`: `postgres`
   - `DB_PASSWORD`: (Copy from PostgreSQL credentials)
   
   **OR use DATABASE_URL** (simpler):
   - `DATABASE_URL`: (Copy the Internal Database URL from PostgreSQL service)

5. Click "Create Web Service"

## Environment Variables

The backend needs these environment variables:

```
PORT=3000
DB_HOST=<your-postgres-host>
DB_PORT=5432
DB_NAME=mydb
DB_USER=postgres
DB_PASSWORD=<your-postgres-password>
```

**Note**: Render PostgreSQL provides an internal URL that includes all connection details.

## Important Notes

1. **Free Tier Limitations**:
   - Services spin down after 15 minutes of inactivity
   - First request after spin-down takes 30-60 seconds
   - 750 hours/month free (enough for one service running 24/7)

2. **Database Persistence**:
   - Free PostgreSQL databases are deleted after 90 days of inactivity
   - Upgrade to paid plan for production use

3. **Service Communication**:
   - Use the internal hostname for database connections
   - Render provides automatic internal networking between services

4. **Health Checks**:
   - Backend includes `/api/health` endpoint
   - Render will use this to monitor service health

## Testing Your Deployment

Once deployed, test your backend:

1. **Health Check**:
   ```
   https://tp-backend.onrender.com/api/health
   ```

2. **API Endpoint**:
   ```
   https://tp-backend.onrender.com/api
   ```

3. **Get Messages**:
   ```
   https://tp-backend.onrender.com/api/messages
   ```

## Updating Your Deployment

Render automatically deploys when you push to your GitHub repository:

```bash
git add .
git commit -m "Update backend"
git push origin main
```

## Troubleshooting

1. **Database Connection Issues**:
   - Verify environment variables are correct
   - Check that DB_HOST uses the internal hostname
   - Ensure database is in the same region as backend

2. **Service Won't Start**:
   - Check the logs in Render Dashboard
   - Verify Dockerfile builds correctly locally
   - Ensure all dependencies are in package.json

3. **Slow First Request**:
   - This is normal for free tier services
   - Services spin down after 15 minutes of inactivity
   - Consider upgrading to paid tier for always-on services

## Cost

- **PostgreSQL Database**: Free (up to 90 days inactive)
- **Backend Web Service**: Free (750 hours/month)
- **Total**: $0/month for development and testing

For production, consider upgrading to paid plans for:
- Always-on services (no spin-down)
- Persistent databases
- Better performance
- Custom domains with SSL
