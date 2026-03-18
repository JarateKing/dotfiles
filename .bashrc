# functionality
HISTCONTROL=ignoreboth  # do not store duplicate lines or lines that start with space
HISTSIZE=2000           # lines stored for the current session
HISTFILESIZE=2000       # lines stored between sessions
shopt -s globstar       # support ** wildcards

# path
if ! [[ "$PATH" =~ "$HOME/scripts:" ]]; then PATH="$HOME/scripts:$PATH"; fi
export PATH

# env
export GIT_EDITOR="nvim +startinsert"
export YAZI_CONFIG_HOME=~/.config/yazi # for windows compatibility

# aliases
alias q="exit"
alias please="sudo -E "
alias reload_bashrc="source ~/.bashrc"
alias reload_inputrc="bind -f ~/.inputrc"
alias _emacs="nix-shell ~/nix-shells/emacs.nix"
alias _art="export NIXPKGS_ALLOW_UNFREE=1; nix-shell --impure ~/nix-shells/art.nix"

# functions
## cd and ls combined
## with no argument, will ls with extra info (ie. git status)
## with an argument, will cd to the directory and ls as well.
cs() {
    if [ "$@" ]; then
        if ! cd "$@" ; then
            return
        fi
    fi
    ls -a --color=auto --hyperlink --group-directories-first --ignore=.
    if [ -d ".git" ]; then
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
		builtin cd -- "$cwd"
		if [ -d ".git" ]; then
			echo ""
			git status -s -b
		fi
	fi
	rm -f -- "$tmp"
}
## git log suited for overviews
gitlogs() {
	git log --graph --pretty=tformat:"%Cred%an %Creset%s %Cgreen%as" "$@"
}
## git log with all the info
gitlogx() {
	git log --pretty=tformat:"%C(auto,yellow)%H %Cgreen%s%Creset%nAuthor: %an %Cred%ae %Creset%aI %Cblue%G? %GS%Creset%nCommit: %cn %Cred%ce %Creset%cI %Cblue%GT%Creset%n%b%N" "$@"
}

# prompts
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}
parse_directory() {
    local fulldir=$(dirs +0)
    if [[ "$fulldir" = "~" ]]; then
        echo "~"
    else
        echo -e "$(dirname $fulldir)/\e[1m$(basename $fulldir)"
    fi
}
parse_infoline()
{
    local infoline=''

    if [[ -n "$IN_NIX_SHELL" ]]; then
        if tput setaf 1 >&/dev/null; then
            infoline+="\[\e[0m\e[37m\]Nix:\[\e[0m\e[1m\e[2m\]$(($SHLVL-1)) "
        else
            infoline+="Nix:$(($SHLVL-1)) "
        fi
    fi

    if tput setaf 1 >&/dev/null; then
        infoline+='\[\e[0m\e[37m\]$(parse_directory)'
        infoline+='\[\e[0m\e[32m\e[2m\]$(parse_git_branch)'
    else
        infoline+='$(parse_directory)'
        infoline+='$(parse_git_branch)'
    fi

    echo -e $infoline
}
setup_prompts() {
    if tput setaf 1 >&/dev/null; then
        local prompt_start='\[\e[0m\e[32m\e[1m\]'
        local prompt_end='\[\e[0m\e[39m\]'
        local infoline_bracket='\[\e[0m\e[90m\]'
    fi
    
    # apply to prompts
    PS1="$infoline_bracket[$(parse_infoline)$infoline_bracket]"$'\n'"$prompt_start > $prompt_end"
    PS2="$prompt_start . $prompt_end"
    PS4="$prompt_start + $prompt_end"

    # PS3 needs special handling for escape sequences
    if tput setaf 1 >&/dev/null; then
        PS3=$'\e[0m\e[32m\e[1m ? \e[0m\e[39m'
    else
        PS3=" ? "
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
