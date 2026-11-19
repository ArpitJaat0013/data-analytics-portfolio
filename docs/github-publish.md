# Publishing this repository to GitHub

The local repo is already initialized on the `main` branch.

## One-time authentication

```bash
gh auth login --web
# GitHub.com -> HTTPS -> authorize in browser -> paste one-time code
gh auth status
```

## Create the remote and push

```bash
cd "/Users/dikshitpunwar/Documents/Default Project/data-analytics-portfolio"

# commit locally first (identity comes from your GitHub account)
git add .
git commit -m "Initial portfolio structure"

# create the remote and push
gh repo create data-analytics-portfolio --public --source=. --remote=origin --push
```

Use `--private` instead of `--public` if you want it hidden while the capstones are in progress.

## Useful follow-ups

```bash
git remote -v                       # verify the remote URL
git status                          # confirm a clean working tree
gh repo view --web                  # open the repo in your browser
```

If Git has no commit identity set:

```bash
git config user.name "YOUR_GITHUB_NAME"
git config user.email "YOUR_ID+YOUR_USERNAME@users.noreply.github.com"
```
