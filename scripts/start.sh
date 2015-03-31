export DISPLAY=:99
Xvfb :99 -shmem -screen 0 1366x768x16 &
x11vnc -display :99 -N -forever &

CUST_VERSION="udp"

# block udp
if [ -n "${BLOCKUDP+1}" ]; then
  echo "udp is blocked"
  iptables -A INPUT -p udp --sport 100:65535 --dport 100:65535 -j DROP
  iptables -A OUTPUT -p udp --sport 100:65535 --dport 100:65535 -j DROP
else
  echo "udp is not blocked"
fi

su - chromeuser &
selenium-standalone start -- $@
