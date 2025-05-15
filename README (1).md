# 🏠 Self-Hosted Media Gateway using Docker and Proxmox

## 📖 Overview
This project demonstrates a home media gateway setup using Docker containers for Jellyfin and NGINX, with `dnsmasq` for DNS resolution—running inside a Proxmox virtual environment on my old laptop (Acer Aspire, i5 7th Gen, 8GB RAM). It includes automation via `cron`, logging with `logrotate`, and container visibility using Portainer.

---

## 🧰 Stack

- **Proxmox VE** (host)
- **Ubuntu Server VM**
- **Docker + Portainer**
- **Jellyfin** (media server)
- **NGINX** (reverse proxy)
- **dnsmasq** (local DNS)
- **cron** (automation)
- **logrotate** (log management)

---

## ⚙️ Setup Process

### 1️⃣ VM Creation on Proxmox

- Download the latest Proxmox VE ISO from the official site:  
  https://www.proxmox.com/en/downloads/proxmox-virtual-environment/iso
- Create a bootable USB using a tool like **Rufus**.
- Install Proxmox on your hardware and access the Web UI:  
  https://<your-ip>:8006
- Create a new VM for Ubuntu Server from the Web UI.

---

### 2️⃣ Docker Installation

- Set up the Docker APT repository by following the official Docker guide:  
  https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

- Install Docker components:
  ```bash
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  ```

- Add your user to the Docker group:
  ```bash
  sudo usermod -aG docker $USER
  ```

---

### 3️⃣ Container Deployment

- Use **Portainer Web UI** to deploy containers.
- Configuration files for:
  - Docker Compose
  - NGINX
  - Jellyfin  
  ...are available in the `setup/` directory of this repository.

---

### 4️⃣ Configure `dnsmasq`

- Install:
  ```bash
  sudo apt install dnsmasq
  ```

- Edit `/etc/dnsmasq.conf`:
  ```
  address=/jellyfin.lan/192.168.0.101
  address=/portainer.lan/192.168.0.101
  ```

- Restart service:
  ```bash
  sudo systemctl restart dnsmasq
  ```

- Ensure client devices use this machine as their DNS server:
  - Set manually on each device
  - Or configure it on your router's DHCP settings

- Sample config available in `setup/dnsmasq/`.

---

### 5️⃣ Cron Jobs & Logrotate

- Add cron jobs using:
  ```bash
  crontab -e
  ```

- Example:
  ```bash
  0 2 * * * /home/youruser/scripts/service-check.sh >> /var/log/service-check.log
  ```

- Scripts available in `automation/scripts/`.

- Sample logrotate config is available in `automation/`.

---

## 🌟 Features

- Local DNS resolution for Docker-hosted services
- Reverse proxy with NGINX inside a Docker container
- Automated container health checks via `cron`
- Rotated service logs using `logrotate`
- Portainer dashboard for Docker visibility and control

---

## 📚 Lessons Learned

- Managing and troubleshooting services inside Docker containers and Linux VMs
- Automating system checks and log management with `cron`
- Setting up lightweight DNS and reverse proxy solutions
- Building a functional system under hardware constraints