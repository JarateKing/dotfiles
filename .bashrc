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

# style
setup_prompts() {
	if tput setaf 1 >&/dev/null; then
		local prompt_start='\[\e[32m\e[1m\]'
		local prompt_end='\[\e[0m\e[39m\]'
	fi
	PS1="$prompt_start > $prompt_end"
	PS2="$prompt_start . $prompt_end"
	PS3="$prompt_start ? $prompt_end"
	PS4="$prompt_start + $prompt_end"
}
setup_prompts
