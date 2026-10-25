# for use within this bashrc
if tput setaf 1 >&/dev/null; then
	HAS_COLOR=1
fi

# general functionality
shopt -s globstar                 # support ** wildcards
shopt -s no_empty_cmd_completion  # prevent long delay on tab with empty completion
shopt -s dotglob                  # include dotfiles in *

# path
if ! [[ "$PATH" =~ "$HOME/scripts:" ]]; then PATH="$HOME/scripts:$PATH"; fi
export PATH

# history
HISTCONTROL=ignoreboth:erasedups  # do not store duplicate lines or lines that start with space
HISTSIZE=2000                     # lines stored for the current session
HISTFILESIZE=2000                 # lines stored between sessions
shopt -s histappend               # better history with multiple sessions

# keep history updated even if closing suddenly
if ! [[ "$PROMPT_COMMAND" =~ "history -a" ]]; then
	if [[ -n "$PROMPT_COMMAND" ]]; then
		PROMPT_COMMAND="$PROMPT_COMMAND;history -a";
	else
		PROMPT_COMMAND="history -a"
	fi
fi

# env
## config paths are usually for windows compatibility
export GIT_EDITOR="nvim +startinsert"
export YAZI_CONFIG_HOME=~/.config/yazi
export RIPGREP_CONFIG_PATH=~/.ripgreprc
export DOGGO_CONFIG=~/.config/doggo/config.toml
export BAT_CONFIG_PATH=~/.config/bat/bat.conf

# aliases
alias q="exit"
alias please="sudo -E "
alias reload_bashrc="source ~/.bashrc"
alias reload_inputrc="bind -f ~/.inputrc"
alias _emacs="nix-shell ~/nix-shells/emacs.nix"
alias _art="export NIXPKGS_ALLOW_UNFREE=1; nix-shell --impure ~/nix-shells/art.nix"

# functions
## comment out within a pipeline
### ie. `ls | __ sort -nr | grep .md` ignores the `sort`
__() {
	cat
}
## print commands as they're executed within scripts
### ie. `verbose palette`
verbose() {
	trap "{ set +x; } 2>/dev/null" SIGINT
	set -x
	{ export SHELLOPTS; } 2>/dev/null
	"$@"
	{ set +x; } 2>/dev/null
}
## cd and ls combined
### with no argument, will ls with extra info (ie. git status)
### with an argument, will cd to the directory and ls as well.
### with - as the argument, will go to the previous directory.
cs() {
    if [ "$@" ]; then
		if [ "$@" = "-" ]; then
			if ! command popd > /dev/null ; then
				return
			fi
		else
			if ! command pushd "$@" > /dev/null ; then
				return
			fi
		fi
    fi
    ls -a --color=auto --hyperlink --group-directories-first --ignore=.
    if [ -e ".git" ]; then
        echo ""
        git status -s -b
    fi
}
## cs directories, edit files (in neovim)
cse() {
	if [ -d "$@" ]; then
		cs "$@"
	else
		nvim "$@"
	fi
}
## cd using yazi
cz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	if [ "$cwd" != "$PWD" ] && [ -d "$cwd" ]; then
		cs "$cwd"
	fi
	rm -f -- "$tmp"
}
## mkdir then cs to it
mkcs() {
	mkdir -p "$@"
	cs "$@"
}
## cs to a temporary directory
tempcs() {
	cs "$(mktemp -d)"
}

# completions
source ~/scripts/completions.sh

# prompts
parse_git_branch() {
	PROMPT_GIT_BRANCH=""
	local dir="$PWD"
	local head=""
	
	while [[ -n "$dir" ]]; do
		if [[ -f "$dir/.git/HEAD" ]]; then
			read -r head < "$dir/.git/HEAD"
			break
		fi
		
		# need to ask git directly for worktrees and submodules
		if [[ -f "$dir/.git" ]]; then
			head=$(git symbolic-ref --short -q HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
			PROMPT_GIT_BRANCH=" $head"
			return
		fi
		
		dir="${dir%/*}"
		
		# copy GIT_CEILING_DIRECTORIES behaviour
		if [[ "$dir" = "$HOME" ]]; then
			return
		fi
	done

	if [[ "$head" = "ref: refs/heads/"* ]]; then
		PROMPT_GIT_BRANCH=" ${head#ref: refs/heads/}"
	elif [[ -n "$head" ]]; then
		PROMPT_GIT_BRANCH=" ${head:0:7}"
	fi
}
parse_directory() {
	local fulldir="${PWD/#$HOME/\~}"
	
	if [[ "$fulldir" = "~" ]]; then
		PROMPT_START_DIR=""
		PROMPT_END_DIR="~"
	elif [[ "$fulldir" = "/" ]]; then
		PROMPT_START_DIR=""
		PROMPT_END_DIR="/"
	else
		PROMPT_START_DIR="${fulldir%/*}/"
		PROMPT_END_DIR="${fulldir##*/}"
	fi
}
update_prompt() {
	parse_directory
	parse_git_branch
}
setup_prompts() {
	if [[ -n "$HAS_COLOR" ]]; then
		local prompt_start='\[\e[0m\e[32m\e[1m\]'
		local prompt_end='\[\e[0m\e[39m\]'
		local infoline_bracket='\[\e[0m\e[40m\e[90m\]'
		local nix_color='\[\e[0m\e[40m\e[37m\]'
		local nix_level_color='\[\e[0m\e[40m\e[1m\e[2m\]'
		local start_dir_color='\[\e[0m\e[40m\e[37m\]'
		local end_dir_color='\[\e[1m\]'
		local git_branch_color='\[\e[0m\e[40m\e[32m\e[2m\]'
	fi

	local infoline="$infoline_bracket["
	if [[ -n "$IN_NIX_SHELL" ]]; then
		infoline+="${nix_color}Nix:$nix_level_color$(($SHLVL-1)) "
	fi
	infoline+="$start_dir_color"'$PROMPT_START_DIR'
	infoline+="$end_dir_color"'$PROMPT_END_DIR'
	infoline+="$git_branch_color"'$PROMPT_GIT_BRANCH'
	infoline+="$infoline_bracket]"

	# the infoline is supposed to have a black bg
	# erasing to the end of the line fills the rest of it with the bg
	if [[ -n "$HAS_COLOR" ]] && [ -n "$WEZTERM_EXECUTABLE" ]; then
		local hfill='\[\e[K\e[0m\]'
	fi

	# handle when stdout doesn't end with a newline
	local newline_correction="\r"

	# apply to prompts
	PS1="$newline_correction$infoline$hfill"$'\n'"$prompt_start > $prompt_end"
	PS2="$newline_correction$prompt_start . $prompt_end"
	PS4="$newline_correction$prompt_start + $prompt_end"

	# PS3 needs special handling for escape sequences
	if [[ -n "$HAS_COLOR" ]]; then
		PS3=$'\r\e[0m\e[32m\e[1m ? \e[0m\e[39m'
	else
		PS3=" ? "
	fi

	# refresh the infoline values before each prompt
	if ! [[ "$PROMPT_COMMAND" =~ "update_prompt" ]]; then
		if [[ -n "$PROMPT_COMMAND" ]]; then
			PROMPT_COMMAND="update_prompt;$PROMPT_COMMAND"
		else
			PROMPT_COMMAND="update_prompt"
		fi
	fi

	# make nix shells use our prompt
	if [[ -n "$IN_NIX_SHELL" ]]; then
		export NIX_SHELL_PRESERVE_PROMPT=1
	fi
}
setup_prompts

# better handle dotfiles repo in the home directory
# any subdirectories won't detect the .git inside ~
# working directory needs to be ~ for dotfiles work
export GIT_CEILING_DIRECTORIES="$HOME"

# shell integrations
if [ -n "$WEZTERM_EXECUTABLE" ] && [ -z "$WEZTERM_INTEGRATION_LOADED" ]; then
	source "$HOME/scripts/wezterm_shell_integration.sh"
	WEZTERM_INTEGRATION_LOADED="True"

	# assume user vars don't change, override to stop recomputing each prompt
	WEZTERM_USER_VARS="$(__wezterm_user_vars_precmd)"
	__wezterm_user_vars_precmd() {
		printf '%s' "$WEZTERM_USER_VARS"
	}
fi

# personal stuff
if [ -f "$HOME/.bashrc-private" ]; then
	source "$HOME/.bashrc-private"
fi
