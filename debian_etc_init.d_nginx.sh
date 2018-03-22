#! /bin/sh
 
### BEGIN INIT INFO
# Provides:          nginx
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the nginx web server
# Description:       starts nginx using start-stop-daemon
### END INIT INFO
 
PATH=/usr/local/nginx
DESC=nginx
NAME=nginx
DAEMON=$PATH/sbin/$NAME
CONFIGFILE=$PATH/conf/$NAME.conf
PIDFILE=$PATH/logs/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME
 
test -x $DAEMON || exit 0
set -e
[ -x "$DAEMON" ] || exit 0
do_start() {
$DAEMON -c $CONFIGFILE || echo -n "nginx already running"
}
do_stop() {
$DAEMON -s stop || echo -n "nginx not running"
}
do_reload() {
$DAEMON -s reload || echo -n "nginx can't reload"
}
case "$1" in
  start)
        echo -n "Starting $DESC: $NAME"
        do_start
        echo "."
        ;;
  stop)
        echo -n "Stopping $DESC: $NAME"
        do_stop
        echo "."
        ;;
  restart|force-reload)
        echo -n "Restarting $DESC: $NAME"
        do_stop
        do_start
        echo "."
        ;;
  reload)
        do_reload() {
        $DAEMON -s reload || echo -n "nginx can't reload"
        }
        ;;
  *)
        N=/etc/init.d/$NAME
        echo "Usage: $N {start|stop|restart|force-reload}" >&2
        exit 1
        ;;
esac
 
exit 0
