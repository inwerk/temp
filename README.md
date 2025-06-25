# Homelab

TODO

## Server Access

Connect to the server via:

```bash
ssh -i ~/.ssh/<PRIVATE-KEY> <USERNAME>@<IP-ADDRESS>
```

## Initial Server Setup

Connect to the server...

```bash
ssh <USERNAME>@<IP-ADDRESS>
```

Update the server...

```bash
sudo apt update
sudo apt upgrade
```

Set the timezone...

```bash
sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
```

Set the system locale...

```bash
sudo sed -i '/^# *de_DE.UTF-8 UTF-8/s/^# *//' /etc/locale.gen
sudo locale-gen
sudo update-locale LANG=de_DE.UTF-8 LANGUAGE=de_DE:de
```

Set up SSH access with an authorized public key...

```bash
mkdir -p ~/.ssh/
echo "<PUBLIC-KEY>" >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/authorized_keys
```

End the current session and connect again...

```bash
exit
ssh -i ~/.ssh/<PRIVATE-KEY> <USERNAME>@<IP-ADDRESS>
```

Set `PermitRootLogin` and `PasswordAuthentication` to `no`, `PubkeyAuthentication` to `yes` and restart SSH...

``bash
sudo nano /etc/ssh/sshd_config
sudo systemctl restart ssh
```

Install and configure UFW...

```
sudo apt install ufw
sudo ufw allow ssh
sudo ufw enable
```

[Install Docker](https://docs.docker.com/engine/install/debian/)...

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the packages:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

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

✅ Implemented.

❌ Planned, not implemented.

## Installation

TODO

### Docker

This Docker installation script implements the [installation instructions for Debian-based systems](https://docs.docker.com/engine/install/debian/) from the official Docker documentation.

```bash
curl -sSL https://raw.githubusercontent.com/inwerk/debian-homelab/master/install-docker.sh | sudo bash
```

Clone this repository...

```bash
git clone https://github.com/inwerk/debian-homelab.git
```

Change the current directory to the project's directory...

```bash
cd debian-homelab
```

Configure the environment variables...

```bash
nano .env
```

...

### Configuration

TODO

### Setup

TODO

## Security

## References
- [How to Secure an SSH Server in Linux](https://www.baeldung.com/linux/secure-ssh-server)
- [Docker Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)
- [MariaDB container as non-root user](https://mariadb.com/kb/en/docker-official-image-frequently-asked-questions/#can-i-run-the-mariadb-container-as-an-arbitrary-user)
- [Health Check for MariaDB](https://mariadb.com/kb/en/using-healthcheck-sh/)
