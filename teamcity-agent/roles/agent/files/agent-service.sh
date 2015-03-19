#!/bin/bash
#
# teamcity-agent      TeamCity Agent
#
# chkconfig: 345 80 30
# description: TeamCity is a continuous Integration Server
# processname: teamcity-agent
# config: /etc/sysconfig/teamcity
#
# Source function library.
. /etc/rc.d/init.d/functions

# Source networking configuration.
if [ -f /etc/sysconfig/teamcity ] ; then
  . /etc/sysconfig/teamcity
else
  echo "No teamcity configuration"
  exit 0
fi

RETVAL=0

start() {
        # Start daemons.
        echo -n $"Starting TeamCity agent: "
        daemon --user teamcity "( cd $AGENT_DIR && bin/agent.sh start )" && success || failure $"$prog start"
        RETVAL=$?
        [ $RETVAL -eq 0 ] && touch /var/lock/subsys/teamcity-agent
        echo
        return $RETVAL
}

stop() {
        # Stop daemons.
        echo -n $"Shutting down TeamCity agent: "
        ( cd $AGENT_DIR && bin/agent.sh stop ) && success || failure $"$prog start"
        RETVAL=$?
        [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/teamcity-agent
        echo
        return $RETVAL
}

restart() {
        stop
        start
}

case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart)
        stop
        start
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart}"
        exit 1
esac

exit $?