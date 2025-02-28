# Homelab

TODO

## About

TODO

## Services

| Service                                                         | Description                            | Status |
| --------------------------------------------------------------- | -------------------------------------- | ------ |
| [Authelia](https://github.com/authelia/authelia)                | Identity and access management         | ❌     |
| [CrowdSec](https://github.com/crowdsecurity/crowdsec)           | Threat detection and prevention        | ❌     |
| [Gitea](https://github.com/go-gitea/gitea)                      | Git repository management              | ❌     |
| [Nextcloud](https://github.com/nextcloud/docker)                | Cloud storage and file synchronization | ✅     |
| [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/)     | DNS filtering and local DNS records    | ❌     |
| [traefik](https://github.com/traefik/traefik)                   | Reverse proxy                          | ✅     |
| [Vaultwarden](https://github.com/dani-garcia/vaultwarden)       | Password manager                       | ❌     |

✅: Implemented.
❌: Planned, not implemented.

## Installation

TODO

### Docker

This Docker installation script implements the [installation instructions for Debian-based systems](https://docs.docker.com/engine/install/debian/) from the official Docker documentation.

```bash
curl -sSL https://raw.githubusercontent.com/inwerk/debian-homelab/master/install-docker.sh | sudo bash
```

### Configuration

TODO

### Setup

TODO

## Security

## References
- [MariaDB container as non-root user](https://mariadb.com/kb/en/docker-official-image-frequently-asked-questions/#can-i-run-the-mariadb-container-as-an-arbitrary-user)
- [Health Check for MariaDB](https://mariadb.com/kb/en/using-healthcheck-sh/)
