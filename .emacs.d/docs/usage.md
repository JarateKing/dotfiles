# Using (My Configuration of) Emacs

Sometimes I share my configuration with people, but it's understandably overwhelming, especially for people not very familiar with emacs. So this is meant to be a quick-start guide for understanding how to use this configuration of emacs.

## Primer

Emacs is pretty old, and some of its conventions predate more common computer conventions. The easiest place to see this is in how we describe keybinds.

If a program wants you to press `control` and `s`, they'll usually describe it as `ctrl + s`. In emacs, this is `C-s`. The `C` stands for control, the `-` means it's modifying another key, and the `s` is the key we need to press with it.

A capital `S` means `shift`, in the same way. You might find keybinds that look like `C-S-d`, which means `ctrl + shift + d`.

Similarly, `alt` on linux and windows and `option` on macs is given as `M-` in emacs. This is a historical quirk, because back in the day some keyboards had a `meta` key, which `M` refers to.

Unlike a lot of more modern text editors, it's pretty common for emacs to use multiple keys per command. `C-x C-c` (the command to quit emacs, not like you'll ever need to!) means "ctrl + x, then ctrl + c".

Emacs also lets you run many commands that don't have a keybind. To do this we'd do `M-x name-of-the-command`, where `name-of-the-command` is typed regularly after `alt + x`.

If you're midway between a command and you want to cancel, you can. Just press `Esc` a few times.

## Keybinds

As a disclaimer, note that a lot of these keybinds are going to be specific to this configuration. There are a lot of defaults that I've changed. For example, `M-w` is the default for copying text, and `C-y` to paste it. This configuration uses the more familiar `C-c` and `C-v`.

### Basic Keybinds

- `C-x C-c` quit emacs
- `C-s` save file
- `C-c` copy text
- `C-v` paste text
- `C-z` undo
- `C-y` redo
- `C-f` find next
- `C-a` select-all

### Intermediate Keybinds

- `C-x d` open dired. This is a file browser directly within emacs.
- `C-x C-f` open file directly, without going through dired.
- `C-t` open terminal. Type `q` to exit.
- `C-x g` open magit. This is a very fast porcelain for git.
- `C-n` attempt to insert a snippet, managed by yasnippet. The snippets can be found in `~/.emacs.d/snippets/`.
- `C-<tab>` cycle between different views. Mostly, it shows whitespace and better shows distinct `()`, `[]`, etc. pairs by colouring them differently.
- `M-!` execute a shell command directly, without going to the terminal.
- `M-|` execute a shell command on the region of text that's selected.
- `M-:` execute some elisp.

### Advanced Keybinds

- `C-/ n` to open a multifile buffer, then `C-/ f` to add files to it. This lets you view multiple files in one buffer, able to scroll between them.
- `C-? e` when multiple lines are selected, create a cursor on each. Press `Enter` to exit multiple-cursor mode.
- `C-? m` when the cursor is over a word, create a cursor for every instance of that word. Press `Enter` to exit multiple-cursor mode.
- `C-d` to create a drawing in org-mode, and `C-S-d` to edit that drawing.
