# Update the local list of packages.
apt update --assume-yes

# Upgrade all the installed packages to their latest versions.
apt full-upgrade --assume-yes

# Uninstall the Docker Engine, CLI, containerd, and Docker Compose packages.
apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Delete all Docker images, containers, and volumes.
rm -rf /var/lib/docker
rm -rf /var/lib/containerd

# Uninstall all conflicting packages.
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get remove $pkg; done
 
# Add Docker's official GPG key.
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources.
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Install the latest Docker version.
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin --assume-yes

# Verify that the installation is successful by running the `hello-world` image.
docker run hello-world
