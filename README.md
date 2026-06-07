# Security Awareness Training Login

Laravel classroom simulation for studying login-page trust cues without copying a real institution or collecting credentials.

The page is available at:

- `/`
- `/training/social-engineering-login`

The form is local-only JavaScript. Submitting clears the fields and opens the debrief panel.

## Edit The UI

The editable login UI is a Vue component:

```text
resources/js/components/TrainingLogin.vue
```

The legacy-style CSS adapted from the provided stylesheet is here:

```text
resources/css/app.css
```

The Blade file only provides the document metadata and Vue mount point:

```text
resources/views/training-login.blade.php
```

Build frontend assets with:

```bash
npm run build
```

## Live Edit With Docker

Use the dev Compose file when you want edits to save on your laptop and update in the browser without rebuilding the image:

```powershell
docker compose -f docker-compose.dev.yml up --build
```

Open:

```text
http://localhost:8000
```

The dev stack also starts MySQL and phpMyAdmin:

```text
Database: cybersec
Username: cybersec
Password: secret
phpMyAdmin: http://localhost:8081
```

Inside Docker, Laravel connects to the database host named `mysql`. From your laptop, the same database is exposed on `127.0.0.1:3306`. If port `3306` is already used by another MySQL/XAMPP service, start the stack with a different host port:

```powershell
$env:MYSQL_PORT=3307; docker compose -f docker-compose.dev.yml up --build
```

Then edit `resources/js/components/TrainingLogin.vue` or `resources/css/app.css`. Vite runs in its own container on port `5173` and hot-reloads the UI.

Stop the dev containers with:

```powershell
docker compose -f docker-compose.dev.yml down
```

If a stale Vite hot file ever makes production look for the dev server, delete `public/hot` and run the production command again.

## Run With Docker

Use this for the production-style container, including Proxmox:

```bash
docker compose up --build
```

Open:

```text
http://localhost:8080
```

On a Proxmox VM or LXC host with Docker installed, copy this project folder to the host and run the same command. Change the exposed host port with:

```bash
APP_PORT=8081 docker compose up --build -d
```

On Windows Docker Desktop, run the same command from PowerShell inside this folder:

```powershell
docker compose up --build
```

If PowerShell says it cannot connect to `dockerDesktopLinuxEngine`, open Docker Desktop first and wait until the engine finishes starting.

If you publish it behind a homelab domain or reverse proxy, set the container URL explicitly:

```bash
DOCKER_APP_URL=https://training.example.test docker compose up --build -d
```

Stop the container with:

```bash
docker compose down
```

## Run Locally Without Docker

For local UI editing, run Vite in one terminal:

```powershell
npm run dev
```

This Windows PHP install may need extensions enabled per command:

```powershell
php -d extension=openssl -d extension=curl -d extension=fileinfo -d extension=mbstring -d extension=pdo_sqlite -d extension=sqlite3 -d extension=zip artisan serve --host=127.0.0.1 --port=8000
```

Open:

```text
http://127.0.0.1:8000
```

## Test

```powershell
php -d extension=openssl -d extension=curl -d extension=fileinfo -d extension=mbstring -d extension=pdo_sqlite -d extension=sqlite3 -d extension=zip vendor\bin\phpunit
```
