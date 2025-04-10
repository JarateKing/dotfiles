# functionality
HISTCONTROL=ignoreboth  # do not store duplicate lines or lines that start with space
HISTSIZE=2000           # lines stored for the current session
HISTFILESIZE=2000       # lines stored between sessions
shopt -s globstar       # support ** wildcards

# path
if ! [[ "$PATH" =~ "$HOME/scripts:" ]]; then PATH="$HOME/scripts:$PATH"; fi
export PATH

# aliases
alias reload_bashrc="source ~/.bashrc"
alias reload_inputrc="bind -f ~/.inputrc"

alias _emacs="nix-shell ~/nix-shells/emacs.nix"

# style
setup_prompts() {
	if tput setaf 1 >&/dev/null; then
		local prompt_start='\[\e[32m\e[1m\]'
		local prompt_end='\[\e[0m\e[39m\]'
		local prefix_start='\[\e[90m\e[1m\]'
	fi
	if [[ -n "$IN_NIX_SHELL" ]]; then
		export NIX_SHELL_PRESERVE_PROMPT=1
		local prompt_prefix="$prefix_start[$(($SHLVL-1))]"
	fi
	PS1="$prompt_prefix$prompt_start > $prompt_end"
	PS2="$prompt_prefix$prompt_start . $prompt_end"
	PS3="$prompt_prefix$prompt_start ? $prompt_end"
	PS4="$prompt_prefix$prompt_start + $prompt_end"
}
setup_prompts

