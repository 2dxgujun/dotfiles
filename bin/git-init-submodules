#!/bin/sh

git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
	while read path_key path
	do
		if [[ ! $(git submodule status "$path" 2> /dev/null) ]]; then
			url_key=$(echo $path_key | sed 's/\.path/.url/')
			url=$(git config -f .gitmodules --get "$url_key")
			echo "Adding $url to $path"
			git submodule add "$url" "$path"
		fi
	done

echo "Done"