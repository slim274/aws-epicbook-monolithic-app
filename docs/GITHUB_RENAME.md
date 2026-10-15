# Rename the Existing GitHub Repository — EpicBook

**Original GitHub name:** `slim274/aws-two-tier-high-availability`  
**Correct EpicBook name:** `slim274/aws-epicbook-monolithic-app`

Do **not** create a second repository for EpicBook. Rename the existing repository that already contains `theepicbook` application code; GitHub preserves commits, branches, and issues when renaming.

1. Open your existing GitHub repository → **Settings** → **General** → **Repository name**.
2. Change the name to `aws-epicbook-monolithic-app` and click **Rename**.
3. Update the GitHub description to:

   `EpicBook monolithic Node.js/Express app deployed on AWS EC2 with Nginx reverse proxy and private Amazon RDS MySQL.`

4. On Ubuntu, in the existing `theepicbook` Git working directory, run:

   ```bash
   git remote set-url origin https://github.com/slim274/aws-epicbook-monolithic-app.git
   git remote -v
   ```

5. Make a backup of your existing README and documentation. Replace **only** the `README.md`, `docs/`, `diagrams/`, and `screenshots/` in that working directory with files from this ZIP. **Leave application code and `.git` intact.** Remove obsolete PHP/WordPress screenshots and `docs/operations-and-recovery.md` from the EpicBook repo.
6. Stage and inspect before committing; confirm no secrets are tracked:

   ```bash
   git status --short
   git add README.md docs diagrams screenshots .gitignore
   git diff --cached --name-only
   git check-ignore -v config/config.json
   ```

After reviewing the staged changes, commit and push to **origin main**. Do not push to the original author's `upstream` remote.

**Related, separate repository:** WordPress high-availability work is documented under `aws-wordpress-alb-rds` (to review later).
