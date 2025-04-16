# Ansible Roles for LAMP Stack Management (RHEL / Oracle Linux)

This repository contains a set of Ansible roles designed to manage a LAMP (Linux, Apache, MariaDB, PHP) hosting environment across multiple servers. It provides centralized and secure configuration for Apache + PHP-FPM and MariaDB, cleanup of obsolete websites, and deployment of virtual hosts, PHP-FPM pools, and self-signed certificates.
It is for me a beta version which can and should evolve. Feel free to use this repo as a base for your further improvements.

> ⚠️ **Supported Operating Systems:**  
> These roles are tested and supported on **Red Hat Enterprise Linux (RHEL)** and **Oracle Linux** only.

## 📦 Roles Overview

### 1. **Apache + PHP-FPM Configuration**
Sets up a secure Apache + PHP-FPM server with:
- Chrooted environments for Apache and PHP-FPM.
- Separate FPM pools per site/app for isolation.
- Support for multiple PHP versions (add them via `php_used_versions` variable in `roles/build_apache/defaults/main.yml`).
- Uses SFTP instead of FTP for file access.

### 2. **MariaDB Configuration**
Prepares a secure MariaDB server by:
- Installing and configuring MariaDB.
- Creating users, databases, and managing access control.
- Tuning and securing defaults through variables.

### 3. **Website Cleanup**
Automatically removes no-longer-used websites/web applications:
- Cleans files, configs, and associated resources.
- Controlled via a `sites-disabled` list in `group_vars`.

### 4. **Deploy Virtual Hosts & PHP-FPM Pools**
Deploys websites/webapps using LAMP stack:
- Apache virtual hosts and FPM pool configs.
- Optionally issues self-signed certificates.
- Controlled via  `sites-enabled` list in `group_vars`.

---

## 📁 Directory & Inventory Setup

Delegating tasks to right remote host is managed by ansible_host IP matching, but way of handling this can be changed to any other option which fits in your scenario.

Inventory example (`inventory.ini`):
```ini
[dev_hosting]
dev-www01 ansible_host=192.168.2.100
dev-dbs01 ansible_host=192.168.1.100

