<VirtualHost _default_:80>
        ServerAdmin justin@dray.be
        Redirect / https://www.dray.be/
</VirtualHost>

<VirtualHost _default_:443>

	ServerAdmin justin@dray.be
	DocumentRoot /srv/http
	ErrorLog "/var/log/httpd/www-error_log"
	TransferLog "/var/log/httpd/www-access_log"

	ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9000/srv/http/$1
	<Directory />
		Options Indexes FollowSymLinks
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>

	SSLEngine on

	SSLCertificateFile    /etc/ssl/certs/www.dray.be.crt
	SSLCertificateKeyFile /etc/ssl/private/www.dray.be.pem
        SSLCertificateChainFile /etc/ssl/certs/sub.class1.server.ca.pem
        SSLCACertificateFile /etc/ssl/certs/ca.pem
	
	<FilesMatch "\.(cgi|shtml|phtml|php)$">
		SSLOptions +StdEnvVars
	</FilesMatch>
	<Directory /usr/lib/cgi-bin>
		SSLOptions +StdEnvVars
	</Directory>

</VirtualHost>
