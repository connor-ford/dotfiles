#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;

function run() {
    rsync --exclude ".git/" \
        --exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
        -avh --no-perms . ~;
    source ~/.profile
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	run;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		run;
	fi;
fi;
unset run;