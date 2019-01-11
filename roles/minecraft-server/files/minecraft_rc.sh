#!/bin/sh
#
# 
#
# PROVIDE: minecraft
# REQUIRE: LOGIN DAEMON NETWORKING mountcritlocal
# KEYWORD: shutdown
#
# Add the following lines to /etc/rc.conf.local to enable the minecraft server:
#
# minecraft_enable="YES"
# minecraft_user="<run server as this user>"
# minecraft_chdir="<run server in this directory>"
# minecraft_path="<path to minecraft_server.jar>"
# minecraft_flags="<set as needed>"
#
# For default setup, create a user named 'minecraft', set its home directory
# to /srv/minecraft, and place minecraft_server.jar into /srv/minecraft
#
# See minecraft_server.jar for flags

. /etc/rc.subr

name=minecraft
rcvar=`set_rcvar`

load_rc_config ${name}

command=/usr/local/bin/screen
pidfile=/var/run/minecraft.pid

start_cmd="${name}_start"
stop_cmd="${name}_stop"
status_cmd="${name}_status"

: ${minecraft_enable="NO"}
: ${minecraft_session="minecraft-session"}
: ${minecraft_user="minecraft"}
: ${minecraft_chdir="/srv/minecraft"}
: ${minecraft_path="/srv/minecraft/minecraft_server.jar"}
: ${minecraft_flags=""}
: ${minecraft_args="/usr/local/bin/java -Xms1024M -Xmx8192M \
                    -jar ${minecraft_path} ${minecraft_flags} nogui"}

minecraft_start() {
    unset "${rc_arg}_cmd"
    minecraft_flags="-d -m -S ${minecraft_session} ${minecraft_args}"
    if minecraft_running; then
      echo "minecraft already running?"
    else
      run_rc_command "start"
    fi
}

minecraft_stop() {
    local cmd
    cmd="${command} -p 0 -S ${minecraft_session} -X eval 'stuff stop\015'"
    if minecraft_running; then
      echo "Stopping minecraft."
      su -m ${minecraft_user} -c "${cmd}"
    fi
}

minecraft_status() {
    if minecraft_running; then
      echo "minecraft is running."
    else
      echo "minecraft is not running."
    fi
}

minecraft_running() {
    local check ses
    ses="${minecraft_session}"
    check=`su -m ${minecraft_user} -c "${command} -list" | grep ${ses}`
    if [ "$check" ]; then
      return 0
    else
      return 1
    fi
}

run_rc_command "$1"
