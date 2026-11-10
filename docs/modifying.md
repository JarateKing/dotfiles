# Modifying

If you wish to make changes to any files that have already been included, feel free! You can then commit and push them through git as usual.

If you're adding new files, you may need to add them to `.gitignore`, in a format like `!.bashrc` to tell git to specifically *not* ignore these files (as our `.gitignore` ignores everything by default). We use `.gitignore` to keep our git statuses clean, but it does mean we need to manually unignore things when we add them.

You can unignore individual files or entire directories, as well as re-ignore parts of unignored directories:

```gitignore
# unignore individual files
!.bashrc

# unignore entire directories
!.emacs.d/
!.emacs.d/**

# and re-ignore files/subdirectories in unignored directories
# this should be placed after unignoring the parent directory
.emacs.d/elpa/
```
