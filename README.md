# Tech Founder University: your private website

Log in on any device and see the same notes, files, assignments and scores.
No server code. Supabase handles login, database and file storage.

Files in this folder:
- `index.html`  the whole app
- `config.js`   where you paste your 2 Supabase values
- `schema.sql`  creates the tables, one time
- `README.md`   this guide

---------------------------------------------------------------

## Part 1. Set up Supabase (about 10 minutes)

1. Go to supabase.com, open the dashboard, click **New project**.
   Name it `tfu`, make a database password (save it somewhere), pick the region
   closest to you, click Create. Wait until it finishes setting up.

2. Open **SQL Editor** (left menu), click **New query**.
   Open `schema.sql` from this folder, copy everything, paste it, click **Run**.
   You should see "Success". This only needs to be done once.

3. Get your two keys: **Project Settings -> API** (it may be called
   "API Keys"). Copy:
   - **Project URL**
   - the **anon** key (newer dashboards call it the **publishable** key)
   Do NOT use the `service_role` / `secret` key. Ever.

4. Open `config.js` in VS Code and paste them between the quotes:
   ```js
   window.TFU_CONFIG = {
     url: "https://abcdxyz.supabase.co",
     key: "eyJ...your public key..."
   };
   ```
   The public key is safe to keep in GitHub. The rules in `schema.sql` are what
   protect your data.

5. Login settings: **Authentication** in the left menu.
   - Find the Email provider settings. For a personal site, turning
     **Confirm email** OFF makes your first sign-up instant.
   - Dashboard menus move around between versions. If you can't find something,
     use the search box in the dashboard or check Supabase's Auth docs.

## Part 2. Try it on your computer

1. Open this folder in VS Code.
2. Install the **Live Server** extension, right-click `index.html`,
   choose **Open with Live Server**.
3. Click **Create account**, enter your email and a strong password.
4. You should land on the Home screen. Add a note, refresh the page: it should
   still be there.

## Part 3. Lock it to just you

After your account works, go back to **Authentication** and turn OFF
**Allow new users to sign up** (it may be listed under sign-in / providers
or user signups). Now nobody else can create an account on your site.

## Part 4. Put it online

1. Create a GitHub repository (private is fine). Push this folder to it.
   In the VS Code terminal:
   ```
   git init
   git add .
   git commit -m "first version"
   git branch -M main
   git remote add origin https://github.com/YOURNAME/tfu.git
   git push -u origin main
   ```
2. On render.com: **New -> Static Site**, connect that repo.
   - Build command: leave empty
   - Publish directory: `.`
   Click Create. In a minute you get a URL like `https://tfu.onrender.com`.
   (GitHub Pages or Netlify also work.)
3. Back in Supabase: **Authentication -> URL Configuration**. Set **Site URL**
   to your new URL. This keeps email links (like password reset) working.
4. On your phone, open the URL. In Safari tap Share -> **Add to Home Screen**.

## Part 5. Bring your old notes over

1. On your old claude.ai version: Home -> **Back up now** (saves a .json file).
2. On the new site, sign in: Home -> **Restore**, pick that file.

---------------------------------------------------------------

## Good to know

- **Free plan pause:** Supabase pauses free projects after 7 days with no
  activity. Your data is kept. Open the Supabase dashboard and click Restore
  project. Using the site regularly avoids this.
- **Free limits:** about 500 MB database and 1 GB of files. Plenty for notes and PDFs.
- **Needs internet.** There is no offline mode.
- **Sync timing:** changes are saved right away. The other device refreshes
  when you switch back to the app or reload.
- **Two devices editing the same note at once:** the last save wins.
- **Weekly backups still matter.** Use Back up now. It downloads a file to your device.
- **Forgot your site password?** Use Supabase dashboard -> Authentication ->
  Users to reset it, or the reset email if you configured the Site URL.
- The passcode and display settings (text size, theme) are per device.
