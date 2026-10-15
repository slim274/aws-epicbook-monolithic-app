# Public GitHub Security Checklist

- Exclude `.env`, private keys, `config/config.json` with real connection values, and `node_modules/`.
- Review `db/` SQL/CSV files for confidential data before committing.
- Review images for AWS account/subscription identifiers, credentials, and private hostnames.
- If credentials were committed **previously**, `.gitignore` alone does not remove them from Git history. Rotate compromised credentials and remediate history appropriately.
- Use least-privilege SG rules: limit SSH, keep RDS private, allow DB TCP 3306 from the application SG only.
- Attribute original EpicBook application code to its original maintainer.

Check staged files before pushing:

```bash
git status --short
git diff --cached --name-only
git ls-files config/config.json .env
```
