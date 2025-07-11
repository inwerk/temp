# Homelab

- [About](#about)
   - [Services](#services)
- [Installation](#installation)
   - [Initial Server Setup](#initial-server-setup)
   - [Container Stack](#container-stack)
- [Maintenance](#maintenance)
  - [Server Access](#server-access)
- [Security](#security)
- [References](#references)

## About

TODO

### Services

| Service                                                         | Description                            | Status |
| --------------------------------------------------------------- | -------------------------------------- | ------ |
| [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/)     | DNS filtering and local DNS records    | ❌     |
| [Authelia](https://github.com/authelia/authelia)                | Identity and access management         | ❌     |
| [cloudflared](https://github.com/cloudflare/cloudflared)        | Cloudflare tunnel                      | ❌     |
| [CrowdSec](https://github.com/crowdsecurity/crowdsec)           | Threat detection and prevention        | ✅     |
| [Gitea](https://github.com/go-gitea/gitea)                      | Git repository management              | ❌     |
| [Nextcloud](https://github.com/nextcloud/docker)                | Cloud storage and file synchronization | ✅     |
| [traefik](https://github.com/traefik/traefik)                   | Reverse proxy                          | ✅     |
| [Vaultwarden](https://github.com/dani-garcia/vaultwarden)       | Password manager                       | ✅     |

✅ Implemented.

❌ Planned, not implemented.

## Installation

TODO

### Server Configuration

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

```bash
sudo nano /etc/ssh/sshd_config
sudo systemctl restart ssh
```

Install and configure UFW...

```bash
sudo apt install ufw
sudo ufw allow ssh
sudo ufw enable
```

Prepare [UFW for Docker](https://github.com/chaifeng/ufw-docker#solving-ufw-and-docker-issues)...

```bash
sudo nano /etc/ufw/after.rules
```

Add the following rules at the end of the file:

```
# BEGIN UFW AND DOCKER
*filter
:ufw-user-forward - [0:0]
:ufw-docker-logging-deny - [0:0]
:DOCKER-USER - [0:0]
-A DOCKER-USER -j ufw-user-forward

-A DOCKER-USER -j RETURN -s 172.16.0.0/12

-A DOCKER-USER -p udp -m udp --sport 53 --dport 1024:65535 -j RETURN

-A DOCKER-USER -j ufw-docker-logging-deny -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -d 172.16.0.0/12
-A DOCKER-USER -j ufw-docker-logging-deny -p udp -m udp --dport 0:32767 -d 172.16.0.0/12

-A DOCKER-USER -j RETURN

-A ufw-docker-logging-deny -m limit --limit 3/min --limit-burst 10 -j LOG --log-prefix "[UFW DOCKER BLOCK] "
-A ufw-docker-logging-deny -j DROP

COMMIT
# END UFW AND DOCKER
```

Allow public networks to access docker services via HTTP/HTTPS and restart UFW...

```bash
sudo ufw route allow proto tcp from any to any port 80
sudo ufw route allow proto tcp from any to any port 443
sudo ufw reload
```

Install Docker according to the [installation instructions](https://docs.docker.com/engine/install/debian/) from the official Docker documentation...

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

Add your user to the `docker` group...

```bash
sudo usermod -aG docker $USER
```

### Container Stack

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
cp .env.example .env
nano .env
```

...

## Maintenance

### Server Access

Connect to the server via:

```bash
ssh -i ~/.ssh/<PRIVATE-KEY> <USERNAME>@<IP-ADDRESS>
```

## Security

TODO

## References
- [How to Secure an SSH Server in Linux](https://www.baeldung.com/linux/secure-ssh-server)
- [Docker Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)
- [Health Check for MariaDB](https://mariadb.com/kb/en/using-healthcheck-sh/)
