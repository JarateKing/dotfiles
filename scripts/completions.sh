# script to setup bash completions

OLD_PWD=$PWD

cd ~/scripts/addfile_data
ADDFILE_COMPLETIONS="$(find * -type f)"
_addfile_completions() {
	if [ "${#COMP_WORDS[@]}" != "3" ]; then
		return
	fi
	COMPREPLY=($(compgen -W "$ADDFILE_COMPLETIONS" "${COMP_WORDS[2]}"))
}
complete -F _addfile_completions addfile

cd ~/scripts/replacements_data
REPLACEMENTS_COMPLETIONS="$(find * -type f)"
_replacements_completions() {
	if [ "${#COMP_WORDS[@]}" != "3" ]; then
		return
	fi
	COMPREPLY=($(compgen -W "$REPLACEMENTS_COMPLETIONS" "${COMP_WORDS[2]}"))
}
complete -F _replacements_completions replacements


cd ~/scripts/snippets_data
SNIPPETS_COMPLETIONS="$(find * -type f)"
_snippets_completions() {
	if [ "${#COMP_WORDS[@]}" != "2" ]; then
		return
	fi
	COMPREPLY=($(compgen -W "$SNIPPETS_COMPLETIONS" "${COMP_WORDS[1]}"))
}
complete -F _snippets_completions snippets

cd $OLD_PWD
