
echo "\n[start script] Making virtual display";
Xvfb :1 -screen 0 1366x768x24+32 &

ls -lahG /home/chrome/remote-user-data-dir

sleep 1;

# For more switches : http://peter.sh/experiments/chromium-command-line-switches/
echo "\n[start script] Starting Google Chrome at $@";
google-chrome \
--no-sandbox \
--user-data-dir=/home/chrome/remote-user-data-dir \
--no-first-run \
--remote-debugging-port=9222 \
$@ \
&

sleep 1;

echo "\n[start script] Redirect incoming 9223 to 9222";
socat TCP-LISTEN:9223,fork TCP:127.0.0.1:9222
