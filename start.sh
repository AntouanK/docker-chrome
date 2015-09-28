
echo "\n[start script] Making virtual display";
Xvfb :1 -screen 0 1280x720x16 &

sleep 1;

echo "\n[start script] Starting Google Chrome at $@";
google-chrome \
--no-sandbox \
--user-data-dir=/home/chrome/ \
--no-first-run \
--remote-debugging-port=9222 \
$@ \
&

sleep 1;

echo "\n[start script] Redirect incoming 9223 to 9222";
socat TCP-LISTEN:9223,fork TCP:127.0.0.1:9222
