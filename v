#!/bin/bash

timesb=0
timesf=0
op=1
gui=true
mkdir -p "$HOME/.playwarp/"

help() {
    echo '''
    NAME
       playwarp - wallpaper player

SYNOPSIS
       playwarp [OPTION] . . .

DESCRIPTION
       display wallpaper for x11 as video (mp3, mp4, mov, YouTube, Urls, . . .).
       Sort entries config is in ~/.playwarp after runing script config show up
       fied use hhtps:// to work with url

       Mandatory  arguments  to  long  options are mandatory for short options
       too.

       -c, --config
              load The Spcific config file
       -ng --no-Gui
              use terminal display
       -cn --config-no-gui
              incloud both option
        --help
              print this help

    Warning:
        Inclouding in two option not Supported * playwarp -c config -ng * [X]
        use -cn for more short work.
    For more help see

        --help-video

AUTHOR
       Written by KiraGP-O .

REPORTING BUGS
    GNU coreutils online help: </https://github.com/KiraGp-O//>
    Report any translation bugs to <https://github.com/KiraGp-O/playwarp>
SEE ALSO
    Full documentation <https://github.com/KiraGp-O/playwarp/README.md>
    or available locally via: info "(coreutils) dir invocation"
'''
}
if [ "$1" == '-ng' ]; then
    gui=flase
fi
# Prompt user for input using Zenity
if $gui; then
    inputyw=$(zenity --class=wallpaper_player --name=wallpaper_player --entry --text='\n         <p>Ensert link url or video directory to play<P>\n ' --width=350)
else 
    echo  -n "Hello, $name! Your video:  $color."
    read inputyw
    sleep 0
fi
if [[ ! -f "$HOME/.playwarp/warp.config" ]]; then
    touch "$HOME/.playwarp/warp.config"
    echo '''
:loop : # none for no loop () 
:autrue # noflase for no audio ()
:value=0.9 # 0.0 > x > 1.0 for opaciy ()
:Sb=0 # for sleep before the programe start SB1 SB2 SB3 ... ()
:SA=0 # for sleep after the programe start 1 sleep SA1 and so on ... ()
:random # for random dircatory playing 
#nrandom # for non random dircatory # add : to active it

:video=--gpu-debug --start=2 ^
created By kiraGP-O for open and colsed source usage
    ''' > "$HOME/.playwarp/warp.config"
fi

# help massge
if [ "$1" = '--help' ]; then
    help
fi

# config file
if [ "$1" = '-c' ]; then
    if [ -f "$2" ]; then
        config="$2"
    else
        echo "The file <$2> not found [X]"
        exit 0
    fi
else
    config=$(cat "$HOME/.playwarp/warp.config")
fi
if [ "$1" == 'cn' ]; then
    gui=flase
        if [ -f "$2" ]; then
        config="$2"
    else
        echo "The file <$2> not found [X]"
        exit 0
    fi
fi
# redaing config file
if [[ $config == *':video='* ]]; then
    add=$(grep ':video=' "$HOME/.playwarp/warp.config" | cut -d '^' -f1 | cut -d '=' -f2)
fi
if [[ $config == *':autrue'* ]]; then
    audio='--no-audio'
fi
if [[ $config == *':aufalse'* ]]; then
    audio=''
fi
if [[ $config == *':loop'* ]]; then
    loop='--loop'
fi

if [[ $config == *':none'* ]]; then
    loop=''
fi

if [[ $config == *':random'* ]]; then
    random=true
fi

if [[ $config == *':nrandom'* ]]; then
    random=false
fi

if [[ $config == *':value'* ]]; then
    op=$(grep ':value=' "$HOME/.playwarp/warp.config" | cut -d' ' -f1 | cut -d '=' -f2)
fi

timesb=$(grep ':Sb=' "$HOME/.playwarp/warp.config" | cut -d ' ' -f1 | cut -d '=' -f2)
timesf=$(grep ':SA=' "$HOME/.playwarp/warp.config" | cut -d ' ' -f1 | cut -d '=' -f2)

# Check if input contains "/"
if [[ $inputyw == *"/"* ]]; then # both of diractory and url have * / *
    echo "YouTube URL detected: '$inputyw'"
    # Check network connectivity
    if [[ $inputyw == *"http"* ]]; then
        echo 'Network available'
        if [[ $inputyw =~ ^https?://www\.youtube\.com/watch ]]; then
            if $random; then
                    sleep "$timesb"
                    echo "$inputyw"
                    xwinwrap -fs -fdt -ni -b -nf -un -o $op -debug -- mpv -wid WID $loop $inputyw --input-ipc-server=/tmp/mpvsocket

                    sleep "$timesf"
            else
                sleep "$timesb"
                xwinwrap -fs -fdt -ni -b -nf -un -o $op -debug -- mpv -wid WID $loop $audio $add $inputyw --input-ipc-server=/tmp/mpvsocket
                sleep "$timesf"
            fi
        else
            xwinwrap -fs -fdt -ni -b -nf -un -o $op -debug -- mpv -wid WID $loop $audio $add $inputyw --input-ipc-server=/tmp/mpvsocket

            if $gui; then
                zenity --notification --text="URL is not valid: '$inputyw'"
            fi
            echo "URL is not valid: '$inputyw'"
        fi
    else
        if [[ -d $inputyw ]]; then
            if $random; then
                sleep "$timesb"
                xwinwrap -fs -fdt -ni -b -nf -un -o $op -debug -- mpv -wid WID $loop "$(find "$inputyw" -type f | shuf -n 1)" --input-ipc-server=/tmp/mpvsocket $add
                sleep "$timesf"
            else
                sleep "$timesb"
                xwinwrap -fs -fdt -ni -b -nf -un -o $op -debug -- mpv -wid WID $loop $inputyw --input-ipc-server=/tmp/mpvsocket $add
                sleep "$timesf"
            fi        
        else
            sleep "$timesb"
            xwinwrap -fs -fdt -ni -b -nf -un -o $op -debug -- mpv -wid WID $loop $inputyw --input-ipc-server=/tmp/mpvsocket $add
            echo "warning : the directory is given as file can't play random videos one single file"
            sleep "$timesf"
        fi
    fi
else
    if $gui; then
        zenity --notification --text="URL or Dir UNSupport, try again"
    fi
    echo "URL or Dir UNSupport, try again" $inputyw
fi
