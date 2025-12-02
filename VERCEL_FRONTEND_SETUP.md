# Frontend Deployment to Vercel

## Quick Deploy

Your frontend is already on Vercel. Now you need to connect it to your Render backend.

## Update Frontend URL

**Replace `tp-backend` with your actual Render backend URL** in `index.html`:

```javascript
const API_BASE = window.location.hostname === 'localhost' 
  ? 'http://localhost:3000/api'
  : 'https://YOUR-BACKEND-NAME.onrender.com/api';  // ← Update this!
```

## Your Render Backend URL

After deployment, your backend URL will be something like:
- `https://tp-backend.onrender.com`
- Or check your Render dashboard for the exact URL

## Steps to Connect Vercel Frontend to Render Backend:

### 1. Get Your Render Backend URL
In your Render dashboard, copy the URL (e.g., `https://tp-backend.onrender.com`)

### 2. Update Frontend (Already Done!)
The frontend code now automatically:
- Uses `localhost:3000` for local development
- Uses `tp-backend.onrender.com` for production (Vercel)

### 3. Deploy Frontend to Vercel

If not already deployed, run:
```bash
cd frontend
vercel
```

Or push to GitHub and connect in Vercel dashboard.

### 4. Add Backend URL to Vercel (Optional)

In Vercel dashboard → Your Project → Settings → Environment Variables:
- **Key**: `VITE_API_URL` or `NEXT_PUBLIC_API_URL`
- **Value**: `https://tp-backend.onrender.com/api`

### 5. Update Backend CORS (Already Done!)

The backend now allows:
- ✅ Vercel domains (`.vercel.app`)
- ✅ Render domains (`.onrender.com`)
- ✅ Localhost for development

## Test Your Application

1. **Backend Health Check**:
   ```
   https://tp-backend.onrender.com/api/health
   ```

2. **Frontend on Vercel**:
   ```
   https://your-app.vercel.app
   ```

3. **Click buttons in frontend**:
   - Test Backend Connection
   - Check Database Health
   - Load Messages
   - Add Message

## Important Notes

⚠️ **First Load Delay**: 
- Render free tier services sleep after 15 minutes
- First request may take 30-60 seconds to wake up
- This is normal for free tier

✅ **CORS is Configured**:
- Your Vercel frontend can now call Render backend
- No additional CORS configuration needed

## Troubleshooting

### If frontend can't connect to backend:

1. **Check Backend URL** in `index.html`
2. **Verify backend is deployed** on Render
3. **Test backend directly**: `https://tp-backend.onrender.com/api`
4. **Check browser console** for CORS or network errors
5. **Wait 30-60 seconds** if service was sleeping

### Common Issues:

- ❌ Wrong backend URL → Update in `index.html`
- ❌ Backend sleeping → Wait for wake-up
- ❌ CORS error → Already fixed, redeploy backend
- ❌ Network error → Check backend is running

## Full Application Flow

```
User → Vercel Frontend → Render Backend → Render PostgreSQL
        (Static HTML)     (Docker API)      (Database)
```

Everything is now connected! 🎉
