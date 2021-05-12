function fish_greeting
	echo ""
	neofetch
end

# Fishbone theme, with some tweaks
function fish_prompt
	set --local last_status $status
    show_user_and_host
	show_path
	show_status $last_status
end

function show_user_and_host
    set_color green
    echo -en "["
    set_color red
    echo -en (whoami)
    set_color white
    echo -en "@"
    set_color cyan
    echo -en (hostnamectl --static)
    set_color green
    echo -en "] "
end

function show_path
	set_color blue
	echo -en "["
	set_color yellow
	echo -en (prompt_pwd)
	set_color blue
	echo -en "]"
end

function show_status -a last_status
	set --local current_color "FFF"
	if [ $last_status -ne 0 ]
		set current_color red
	end
	
	set_color $current_color
	echo -en ": "
	set_color normal
end

function fish_right_prompt
    set --local dark_grey 555
    set_color $dark_grey
    show_virtualenv_name
    show_git_info
    echo -en (date +%H:%M:%S)
    set_color normal
end

function show_virtualenv_name
    if set -q VIRTUAL_ENV
        echo -en "["(basename "$VIRTUAL_ENV")"] "
    end
end

function show_git_info
    set --local git_status (git status --porcelain 2> /dev/null)
    set --local dirty ""
    [ $status -eq 128 ]; and return
    if not [ -z (echo "$git_status" | grep -e '^ M') ]
        set dirty "*"
    end
    if not [ -z (echo "$git_status" | grep -e '^[MDA]') ]
        set dirty "$dirty+"
    end
    if not [ -z (git stash list) ]
        set dirty "$dirty^"
    end
    echo -en "("
    echo -en (git_branch_name)$dirty
    echo -en ") "
end

function git_branch_name
    command git symbolic-ref --short HEAD 2> /dev/null;
        or command git show-ref --head -s --abbrev | head -nl 2>/dev/null
end
