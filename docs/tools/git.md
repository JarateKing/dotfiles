# Git

## Setup

To setup git, you should start by creating a `.gitconfig-private` with your user name and email, along with any other computer-specific or person-specific configuration, like so:

```
# global default username
[user]
	email = yournamehere@email.com
	name = UsernameHere

# per-project override(s)
[includeIf "gitdir:~/work/"]
	path = ~/work/.gitconfig
```

## Aliases

There are a few aliases that either serve as shortcuts for common options, or new utilities entirely.

- `git aliases` will show all aliases added to the config.
- `git amend` will modify the most recent commit.
- `git branches` will combine both `git local-branches` and `git remote-branches`.
- `git churn` will show how frequently files were edited.
- `git contributors` will show the repo's contributors as well as how many commits they made.
- `git current-branch` will show the current local branch.
- `git default-branch` will show the default branch on `origin`.
- `git diffs` will show the diffs of both staged and unstaged files.
- `git directory` will show the top-level directory of the current git repo.
- `git discard` will open an interactive menu that can discard individual changes within files.
- `git list-files` lists all currently tracked files, along with basic info like time/author of last modification.
- `git local-branches` lists all local branches, sorted by date.
- `git logs` will show a git log that's suited for surface-level overviews.
- `git logx` is similar but shows more extended information suited for analyzing individual commits.
- `git remote-branches` lists all remote branches, sorted by date.
- `git staging` will open an interactive menu that can stage individual changes within files.
- `git summary` will show various bits of info about the repository.
- `git tags` lists all tags, sorted by date.
- `git uncommit` will undo the most recent commit, bringing the changes back to staging.
- `git unstage` will unstage files that are currently staged.
- `git unstaging` will open an interactive menu that can unstage individual changes within files.
- `git who` will show the current user's name and email, as well as author and committer overrides if need be. Useful if dealing with multiple git identities across different configs.
