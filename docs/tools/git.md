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
- `git largest` will order git commits by number of lines changed. `-f` sorts by files changed, `-a` sorts by lines added, `-d` sorts by lines deleted, `-t` sorts by total lines changed (added + deleted), `-x` sorts by the delta (added - deleted), `-r` sorts in reverse (ascending) order.
- `git list-files` lists all currently tracked files, along with basic info like time/author of last modification.
- `git local-branches` lists all local branches, sorted by date.
- `git logs` will show a git log that's suited for surface-level overviews.
- `git logx` is similar but shows more extended information suited for analyzing individual commits.
- `git remote-branches` lists all remote branches, sorted by date.
- `git raw` shows the raw commit info for the most recent commit, or a given commit passed in by argument.
- `git staging` will open an interactive menu that can stage individual changes within files.
- `git summary` will show various bits of info about the repository.
- `git tags` lists all tags, sorted by date.
- `git uncommit` will undo the most recent commit, bringing the changes back to staging.
- `git unstage` will unstage files that are currently staged.
- `git unstaging` will open an interactive menu that can unstage individual changes within files.
- `git untrack-ignored` will mark files for deletion if they've been added to `.gitignore`.
- `git who` will show the current user's name and email, as well as author and committer overrides if need be. Useful if dealing with multiple git identities across different configs.

## Why No Shortcut Aliases?

A lot of people's gitconfigs, if they make use of aliases like we do, will have a lot of one-or-two-letter aliases for common commands. For example, `git a` for `git add`, `git c` for `git commit`, `git p` for `git push`, etc.

We intentionally don't have those. The reason we don't have those is because they're mostly clutter. By "clutter" I mean something that seems like it might help or be nice to have, but doesn't actually address any workflow problems or annoyances, so it just makes configs larger without providing utility. And they can make configs much larger, some gitconfigs have a hundred shortcuts that have probably never been used once. Even the shortcuts for common actions still don't actually save very much time or act as that much of a convenience. They can help a bit, but realistically not by much.

`git a` is 5 characters long, versus `git add`'s 7. The speedup is pretty negligible when we consider the need to still type `git ` before any alias (and this is ignoring that the arguments are usually by far the longest part of a `git add` command, so we might only be looking at 50 characters instead of 52). If shaving off a few characters were our goal then it'd be better to create new bash aliases `a`, `c`, `p`, etc. which are are only 1 character instead of 7+.

Furthermore, we can do better than just cut down on some characters. That's not really the main problem with the CLI. Most workflows will frequently `git add file1 file2` and `git commit -m "message"` and `git push` one after another. Just shortening it to `git a file1 file2` `git c -m "message"` `git p` doesn't address the slowdown of needing multiple commands in sequence to do one common action, combining them into something like `c file1 file2 "message"` should be significantly better. The length of common commands is the least of our worries about git CLI speeds, the whole workflow (regardless of what the commands are named) isn't built for speed.

That's describing why simple shortcut aliases aren't very worthwhile in my opinion. But we also don't have any `c file1 file2 "message"`-style commands, either. I've gone back-and-forth on this but I also think they're mostly clutter. This is certainly better and I could see more of a justification for it, but I don't think it's the right fix for workflow problems.

We have tools like `gitu` that are a better fit when this sort of stuff matters. With `gitu` we don't need to type out `file1 file2` and stuff like that, we have a more convenient interface that can be a lot faster to use. If I'm going to be making enough commits in a session that typing `git add` becomes tedious, pure CLI (with or without shortcut aliases) is not the right tool for the job and I already have better workflows available for those use cases. `git add file1 file2` is fine for small quick changes, and when it's not then something like `gitu` fits well, so I don't see any real need for `c file1 file2 "message"`-type shortcuts.

Instead of using aliases to try and speed up the git CLI workflow, we're trying to augment it. The aliases that we do have are focused more on simplifying the complex syntax for anything slightly non-standard in git, or bringing utility scripts into a unified `git command` syntax. The former addresses the issue of needing to google any non-trivial git command, the latter addresses the issue of not being able to easily do certain things altogether (either on the CLI or in any git interface).
