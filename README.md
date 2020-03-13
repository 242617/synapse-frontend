# synapse frontent

This is frontend for core service.
You could (soon):
* list online crawlers
* make tasks for them

# Systemd unit

```
[Unit]
Description=Synapse frontend
Requires=docker.service
After=docker.service

[Service]
User=synapse-frontend
Restart=always
ExecStart=/usr/bin/docker run --rm -v /etc/letsencrypt/archive/synapse.chill-out.ru/:/etc/letsencrypt/archive/synapse.chill-out.ru/ -v /etc/letsencrypt/live/synapse.chill-out.ru/:/etc/letsencrypt/live/synapse.chill-out.ru/ -p 80:80 -p 443:443 --name frontend 242617/synapse-frontend
ExecStop=/usr/bin/docker stop frontend

[Install]
WantedBy=local.target
```
