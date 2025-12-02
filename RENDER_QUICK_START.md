# Quick Render Deployment Guide

## 🚀 Deploy to Render in 3 Steps

### Step 1: Push to GitHub
```bash
cd tp-docker-cicd
git add .
git commit -m "Configure for Render deployment"
git push origin main
```

### Step 2: Create Render Account
- Go to https://render.com and sign up
- Connect your GitHub account

### Step 3: Deploy with Blueprint
1. In Render Dashboard, click **"New +"** → **"Blueprint"**
2. Select your `tp-docker-cicd` repository
3. Render will detect the `render.yaml` file automatically
4. Click **"Apply"** to deploy both database and backend

That's it! Render will:
- Create a PostgreSQL database
- Deploy your backend
- Connect them automatically
- Provide you with a public URL

## 📡 Your Backend URL

After deployment completes (3-5 minutes):
```
https://tp-backend.onrender.com/api
https://tp-backend.onrender.com/api/health
https://tp-backend.onrender.com/api/messages
```

## 🔧 Manual Deployment (Alternative)

If you prefer manual setup:

### 1. Create PostgreSQL Database
- Click "New +" → "PostgreSQL"
- Name: `tp-postgres-db`
- Database: `mydb`
- Plan: Free
- Click "Create Database"
- **Copy the Internal Database URL**

### 2. Deploy Backend
- Click "New +" → "Web Service"
- Connect your GitHub repo
- Root Directory: `backend`
- Environment: Docker
- Add environment variable:
  - `DATABASE_URL`: (paste the Internal Database URL)
  - `PORT`: `3000`
- Click "Create Web Service"

## ⚠️ Important Notes

**Free Tier Behavior:**
- Services spin down after 15 minutes of inactivity
- First request after spin-down takes ~30 seconds
- Perfect for development and testing!

**Database:**
- Free PostgreSQL databases have 90 days retention
- Backup important data regularly

## 🧪 Test Your Deployment

```bash
# Health check
curl https://tp-backend.onrender.com/api/health

# Get messages
curl https://tp-backend.onrender.com/api/messages

# Add a message
curl -X POST https://tp-backend.onrender.com/api/messages \
  -H "Content-Type: application/json" \
  -d '{"content": "Hello from Render!"}'
```

## 🔄 Auto-Deploy

Every time you push to GitHub, Render automatically redeploys your backend!

## 💰 Cost

**100% FREE** for this setup:
- PostgreSQL: Free tier
- Backend Web Service: Free tier
- No credit card required

## 📚 More Details

See `RENDER_DEPLOYMENT.md` for comprehensive documentation.
