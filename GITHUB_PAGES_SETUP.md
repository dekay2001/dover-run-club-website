# GitHub Pages Setup Instructions

This document provides step-by-step instructions for deploying the Run Club website to GitHub Pages.

## Prerequisites

- Repository is already created at: https://github.com/dekay2001/dover-run-club-website
- You have admin access to the repository

## Step 1: Enable GitHub Pages

1. Go to your repository on GitHub: https://github.com/dekay2001/dover-run-club-website
2. Click on **Settings** (top menu bar)
3. In the left sidebar, click on **Pages**
4. Under **Source**, select the branch you want to deploy from (typically `main` or `master`)
5. Keep the folder as `/ (root)`
6. Click **Save**

GitHub will now build and deploy your site. This may take a few minutes.

## Step 2: View Your Site

Once deployed, your site will be available at:
- **Default URL**: https://dekay2001.github.io/dover-run-club-website/

**Note**: Since you already have a personal site at `dekay2001.github.io`, this run club site will be at the repository path shown above.

## Step 3: Configure Custom Domain (Optional)

To use a custom domain (e.g., `yourclub.com` or `www.yourclub.com`):

### A. Purchase and Configure Domain

1. **Purchase a domain** from a domain registrar (GoDaddy, Namecheap, Google Domains, etc.)

2. **Configure DNS Records** with your domain registrar:

   For an apex domain (example.com):
   ```
   Type: A
   Name: @
   Value: 185.199.108.153
   
   Type: A
   Name: @
   Value: 185.199.109.153
   
   Type: A
   Name: @
   Value: 185.199.110.153
   
   Type: A
   Name: @
   Value: 185.199.111.153
   ```

   For www subdomain (www.example.com):
   ```
   Type: CNAME
   Name: www
   Value: dekay2001.github.io
   ```

### B. Update CNAME File

1. Edit the `CNAME` file in the root of your repository
2. Replace the commented content with your actual domain:
   ```
   yourclub.com
   ```
   (Do not include `http://` or `https://`)

3. Commit and push the change

### C. Configure in GitHub Settings

1. Go to repository **Settings** > **Pages**
2. In the **Custom domain** field, enter your domain (e.g., `doverrunclub.com`)
3. Click **Save**
4. Wait for DNS check to complete (may take up to 24-48 hours)
5. Once DNS is verified, enable **Enforce HTTPS** (highly recommended)

## Step 4: Verify Deployment

1. Visit your site URL (either the default GitHub Pages URL or your custom domain)
2. Navigate through all pages to ensure they work:
   - Home page (/)
   - Events (/events.html)
   - Pub Runs (/pub-runs.html)
   - Membership (/membership.html)
   - Sponsors (/sponsors.html)

## Step 5: Automatic Builds

GitHub Pages will automatically rebuild your site whenever you push changes to the configured branch. No manual build step is required!

## Troubleshooting

### Site not showing up?
- Check that GitHub Pages is enabled in Settings > Pages
- Verify the correct branch is selected
- Wait a few minutes for the initial build to complete

### Custom domain not working?
- Verify DNS records are correct (use `dig` or `nslookup` to check)
- DNS propagation can take 24-48 hours
- Ensure CNAME file contains only the domain name (no protocol or paths)
- Check for DNS check status in Settings > Pages

### Build failures?
- Check the Actions tab for build logs
- Ensure all Jekyll syntax is correct
- Verify Gemfile and _config.yml are properly configured

### HTTPS not working?
- HTTPS certificate provisioning can take up to 24 hours after DNS verification
- Make sure "Enforce HTTPS" is enabled in Settings > Pages

## Updating Content

To update your website:

1. Edit the relevant files (index.md, events.md, etc.)
2. Commit your changes
3. Push to the configured branch
4. GitHub Pages will automatically rebuild (takes 1-2 minutes)

## Local Development

To test changes locally before pushing:

```bash
# Install dependencies
bundle install

# Run local server
bundle exec jekyll serve

# View at http://localhost:4000
```

## Need Help?

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Configuring a custom domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)

---

Last updated: February 2026
