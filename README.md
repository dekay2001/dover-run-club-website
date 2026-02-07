# Run Club Website

Static website for a local run club — built with Jekyll and hosted on GitHub Pages. Includes race calendar, pub run info, membership details, and sponsor highlights.

## 🏃 About

This is a running club website template. The site features:

- **Events Calendar** - Weekly runs and upcoming races
- **Pub Runs** - Social runs ending at local pubs
- **Membership Information** - How to join and member benefits
- **Sponsor Recognition** - Thanking our community partners

## 🚀 Quick Start

### Prerequisites

- Ruby 2.7 or higher
- Bundler gem

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/dekay2001/dover-run-club-website.git
   cd dover-run-club-website
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Run the site locally**
   ```bash
   bundle exec jekyll serve
   ```

4. **View in browser**
   Open `http://localhost:4000` in your web browser

### Live Reload Development

For automatic rebuilding on file changes:
```bash
bundle exec jekyll serve --livereload
```

## 📁 Project Structure

```
dover-run-club-website/
├── _config.yml          # Jekyll configuration
├── _layouts/            # Page templates
│   ├── default.html     # Base layout
│   └── page.html        # Page layout
├── _includes/           # Reusable components
│   ├── header.html      # Site header and navigation
│   └── footer.html      # Site footer
├── assets/
│   └── css/
│       └── main.css     # Site styles
├── index.md             # Homepage
├── events.md            # Events calendar page
├── pub-runs.md          # Pub runs page
├── membership.md        # Membership info page
├── sponsors.md          # Sponsors page
├── CNAME                # Custom domain configuration
└── Gemfile              # Ruby dependencies
```

## 🌐 GitHub Pages Setup

This site is designed to work seamlessly with GitHub Pages:

### 1. Enable GitHub Pages

1. Go to your repository settings
2. Navigate to "Pages" in the left sidebar
3. Under "Source", select the branch to deploy (usually `main` or `gh-pages`)
4. Click "Save"

### 2. Configure Custom Domain (Optional)

To use a custom domain instead of `username.github.io/repository`:

1. **Update CNAME file**
   - Edit the `CNAME` file in the root directory
   - Replace the placeholder with your domain (e.g., `yourclub.com`)
   - Uncomment the domain line

2. **Configure DNS Settings**
   
   Add these DNS records with your domain registrar:
   
   - For apex domain (`example.com`):
     ```
     Type: A
     Name: @
     Value: 185.199.108.153
     Value: 185.199.109.153
     Value: 185.199.110.153
     Value: 185.199.111.153
     ```
   
   - For www subdomain (`www.example.com`):
     ```
     Type: CNAME
     Name: www
     Value: yourusername.github.io
     ```

3. **Update in GitHub Settings**
   - Go to repository Settings > Pages
   - Enter your custom domain in the "Custom domain" field
   - Enable "Enforce HTTPS" (recommended)

### 3. Build Configuration

The site uses the `github-pages` gem which includes:
- Jekyll
- Compatible plugins
- GitHub Pages specific configurations

No additional build configuration needed!

## ✏️ Content Updates

### Updating Events

Edit `events.md` to add or modify:
- Weekly run schedules
- Upcoming races
- Special events

### Managing Pub Runs

Edit `pub-runs.md` to update:
- Pub run schedule
- Featured locations
- Partner pub information

### Membership Changes

Edit `membership.md` to modify:
- Membership tiers and pricing
- Benefits
- FAQ

### Adding Sponsors

Edit `sponsors.md` to:
- Add new sponsors
- Update sponsor information
- Manage sponsorship tiers

### Styling Changes

Edit `assets/css/main.css` to customize:
- Colors and branding
- Layout and spacing
- Responsive breakpoints

## 🎨 Customization

### Site Configuration

Edit `_config.yml` to change:
- Site title and description
- Contact email
- Base URL for custom domains
- Theme settings

### Navigation

Update navigation links in `_includes/header.html`

### Footer Information

Modify footer content in `_includes/footer.html`

## 📝 License

This project is open source and available under the [GPL-3.0 License](LICENSE).

## 🤝 Contributing

Have suggestions or found a bug? Please open an issue or submit a pull request!

## 📧 Contact

For questions about the club, visit our website or email us at yourclub@example.com

---

Built with ❤️ for the running community
