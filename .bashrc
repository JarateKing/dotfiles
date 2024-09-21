

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
