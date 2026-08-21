@echo off

if not exist "%AppData%\.emacs.d" (
	mklink "%AppData%\.emacs.d" "%UserProfile%\.emacs.d"
)

if not exist "%LocalAppData%\nvim" (
	mklink "%LocalAppData%\nvim" "%UserProfile%\.config\nvim"
)
