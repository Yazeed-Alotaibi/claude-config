# Plan: Deploy yazeed.blog on Netlify with Hostinger domain

## Context
Yazeed just built a PM tools portfolio site (`yazeed-website/` folder: `index.html` + `pm-calculation-desk.html`) and bought a domain from Hostinger. He wants to publish the site on `yazeed.blog` using Netlify (free hosting). This plan walks through the complete deployment workflow with Hostinger-specific nameserver configuration.

## Approach

### Phase 1: Create Netlify site and get deployment
1. Go to **netlify.com** â†’ Sign up with email (or login if exists)
2. Click **"Add new site"** â†’ **"Deploy manually"**
3. Open File Explorer â†’ navigate to `C:\Users\PC\Documents\yazeed-website`
4. Drag the entire `yazeed-website` folder into Netlify's upload box
5. Netlify builds and assigns a temporary URL (e.g., `shiny-fox-123.netlify.app`)
   - **Site is live and testable at this URL**
   - Click the live URL to verify: homepage loads, calculator link works, "Coming soon" cards visible

### Phase 2: Connect yazeed.blog domain in Netlify
1. In Netlify dashboard: **Site settings** â†’ **Domain management** â†’ **Add a domain**
2. Type `yazeed.blog` â†’ click **"Add domain"**
3. Netlify shows a message "Waiting for your nameserver update"
4. Netlify displays **4 nameservers** (e.g., `dns1.p04.nsone.net`, `dns2.p04.nsone.net`, etc.)
   - **Copy these 4 nameserver addresses**

### Phase 3: Update Hostinger nameservers
1. Login to Hostinger control panel (hostinger.com)
2. Find **Domains** â†’ **My Domains** â†’ click `yazeed.blog`
3. Look for **Nameservers** or **DNS Management** section
4. Replace existing nameservers with Netlify's 4 nameservers:
   - Delete the default Hostinger nameservers
   - Paste Netlify's 4 nameservers
   - Click **Save**
5. Wait for propagation (usually 15 min â€“ 1 hour, max 24 hours)
   - Check status in Netlify: go back to **Domain management** â€” it will say "DNS ok" when ready
   - Test: navigate to `https://yazeed.blog` in browser

### Phase 4: Verify site
- Homepage loads correctly at `yazeed.blog`
- Top bar shows "yazeed.blog"
- Calculator card says "Open tool" and links work
- LinkedIn button in topbar goes to correct URL
- Footer shows "Made by Yazeed Alotaibi" with correct LinkedIn link
- Mobile layout responsive at 375px

## Files involved
- **Source**: `C:\Users\PC\Documents\yazeed-website\`
  - `index.html` â€” homepage (14 domains, 33 calculators, 99 metrics hero; 4 tool cards)
  - `pm-calculation-desk.html` â€” calculator (self-contained, 122,694 bytes)
- **Deployed to**: Netlify (free tier, unlimited bandwidth)
- **Domain**: `yazeed.blog` â†’ Netlify nameservers

## Critical UI elements to verify
- [ ] Homepage hero text and stats display correctly
- [ ] "The Project Manager's Calculation Desk" card is clickable
- [ ] "Open tool" button navigates to calculator page
- [ ] Calculator page loads (all 33 calculators visible, search works)
- [ ] LinkedIn link opens correct profile
- [ ] "Coming soon" cards (Dashboard, AI Tools, WBS) are grayed out
- [ ] No broken images or font loading issues
- [ ] Responsive: test at 375px (mobile), 768px (tablet), 1440px (desktop)

## Verification
After deployment:
1. `yazeed.blog` loads in browser
2. Click "Open tool" â†’ PM Calculation Desk loads
3. Test 1-2 calculators (e.g., EVA or PERT) to confirm formulas compute
4. Mobile view: topbar compact, cards stack vertically, no horizontal overflow
5. Console: no JavaScript errors

## Next steps
- Add new tool pages: create `.html` file in `yazeed-website/`, update card `href` on homepage, redeploy to Netlify
- Custom domain email (optional): Hostinger + Netlify can both support email forwarding
