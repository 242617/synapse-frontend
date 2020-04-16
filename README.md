# synapse frontent

Frontend for core service.

# Setup

## Setup user

```
sudo adduser synapse-frontend
sudo adduser synapse-frontend docker
```

## Setup service

Create _/etc/systemd/system/synapse-frontend.service_:

```
[Unit]
Description=Synapse frontend
Requires=docker.service
After=docker.service

[Service]
User=synapse-frontend
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=synapse-frontend
Restart=always
ExecStart=/usr/bin/docker run --rm -p 8080:80 --name synapse-frontend 242617/synapse-frontend
ExecStop=/usr/bin/docker stop synapse-frontend

[Install]
WantedBy=local.target
```

## Logging

Create _/etc/rsyslog.d/synapse-frontend.conf_:

```
if $programname == 'synapse-frontend' then /var/log/synapse-frontend.log
& stop
```

```
sudo touch /var/log/synapse-frontend.log
sudo chown syslog:adm /var/log/synapse-frontend.log
sudo systemctl restart rsyslog
```
