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
parse_git_branch() {
    # todo: apply style
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
setup_prompts() {
	if tput setaf 1 >&/dev/null; then
		local prompt_start='\[\e[0m\[\e[32m\e[1m\]'
		local prompt_end='\[\e[0m\e[39m\]'
        local infoline_bracket='\[\e[0m\[\e[90m\e[1m\]'
		local nixshell_start='\[\e[0m\[\e[37m\]'
        local nixshell_number='\[\e[2m\e[1m\]'
        local directory_start='\[\e[0m\e[37m\]'
        local gitbranch_start='\[\e[0m\[\e[32m\e[2m\]'
	fi
    
    local infoline="$gitbranch_start$(parse_git_branch) $infoline"
    local infoline="$directory_start\w $infoline"
    
	if [[ -n "$IN_NIX_SHELL" ]]; then
		export NIX_SHELL_PRESERVE_PROMPT=1
		local infoline="${nixshell_start}Nix:$nixshell_number$(($SHLVL-1)) $infoline"
	fi
    
	PS1="$infoline_bracket[${infoline::-1}$infoline_bracket]\n$prompt_start > $prompt_end"
	PS2="$infoline_bracket[${infoline::-1}$infoline_bracket]\n$prompt_start . $prompt_end"
	PS3="$infoline_bracket[${infoline::-1}$infoline_bracket]\n$prompt_start ? $prompt_end"
	PS4="$infoline_bracket[${infoline::-1}$infoline_bracket]\n$prompt_start + $prompt_end"
}
setup_prompts

