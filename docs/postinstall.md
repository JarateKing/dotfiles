# Post-install Options

These dotfiles should be mostly setup as long as this repo is directly in the home directory. There's a few smaller things to finish setting up, some of which optional.

## Fonts

There are some fonts that are used by emacs that likely aren't installed by default:

- https://github.com/davestewart/minimap-font/tree/master
- https://www.jetbrains.com/lp/mono/

## Private Configs

You should also setup your personal git configuration in a new `.gitconfig-private` file. For example,

```
# global default username
[user]
	email = yournamehere@email.com
	name = UsernameHere

# per-project override(s)
[includeIf "gitdir:~/work/"]
	path = ~/work/.gitconfig
```

Similar should be done for mercurial as well, in a `.hgrc-private` file:

```
[ui]
username = UsernameHere <yournamehere@email.com>
```

## Removing Git

When you're done installing, you can optionally delete the `.git` folder, `.gitignore`, `.gitattributes`, and `readme.md` files. Doing so would mean your dotfiles are no longer under source control, but would still be functional as dotfiles.
