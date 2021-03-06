<VirtualHost _default_:80>
	ServerName abachi.dray.be
	ServerAlias abachi.dray.be
	ServerAdmin justin@dray.be
	Redirect / https://abachi.dray.be/
</VirtualHost>

<VirtualHost _default_:443>

	ServerAdmin justin@dray.be
	DocumentRoot /srv/http
	ErrorLog "/var/log/httpd/abachi-error_log"
	TransferLog "/var/log/httpd/abachi-access_log"

	<Location />
		Options Indexes FollowSymLinks
		AllowOverride All
		Order allow,deny
		Allow from all
		AuthType Basic
		AuthName "abachi.dray.be"
		AuthUserFile /srv/http/.htpasswd
		Require valid-user
	</Location>

    <Location /icons>
        Allow from all
        Satisfy Any
    </Location>

    <Location /CGP/>
        AuthUserFile /srv/http/.htpasswd
        AuthType Basic
        AuthName "CollectD Graph Panel"
        Require valid-user
        Order allow,deny
        Allow from 192.168.1.0/24
        Satisfy Any
    </Location>

	SSLEngine on

	SSLCertificateFile    /etc/ssl/certs/abachi.dray.be.crt
	SSLCertificateKeyFile /etc/ssl/private/abachi.dray.be.pem
	SSLCertificateChainFile /etc/ssl/certs/sub.class1.server.ca.pem
	SSLCACertificateFile /etc/ssl/certs/ca.pem
	
	<FilesMatch "\.(cgi|shtml|phtml|php)$">
		SSLOptions +StdEnvVars
	</FilesMatch>

	<Directory /usr/lib/cgi-bin>
		SSLOptions +StdEnvVars
	</Directory>

	<Location /bonnie2gchart>
		Satisfy Any
	</Location>
</VirtualHost>
