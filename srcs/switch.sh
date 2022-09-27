FILE=/etc/nginx/sites-enabled/index_on.conf
if [ -f "$FILE" ]; then
	mv "$FILE" .
	mv index_off.conf /etc/nginx/sites-enabled/
else
	mv /etc/nginx/sites-enabled/index_off.conf .
	mv index_on.conf /etc/nginx/sites-enabled
fi
service nginx restart;
