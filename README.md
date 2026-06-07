# Security Awareness Training Login

Laravel classroom simulation for studying login-page trust cues without copying a real institution or collecting credentials.

The page is available at:

- `/`
- `/training/social-engineering-login`

Submitting the form records a sanitized training event in the `training_submissions` table and opens the debrief panel. The app does not store raw passwords; it stores only whether a password was entered and its length.

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

## Run With Docker

Use Docker when you want Laravel, MySQL, phpMyAdmin, and Vite to run together. Edits save on your laptop and update in the browser:

```powershell
docker compose up --build
```

Open:

```text
http://localhost:8000
```

The stack is named `cybersec-dev` and also starts MySQL and phpMyAdmin:

```text
Database: cybersec
Username: cybersec
Password: secret
phpMyAdmin: http://localhost:8081
```

Inside Docker, Laravel connects to the database host named `mysql`. From your laptop, the same database is exposed on `127.0.0.1:3306`. If port `3306` is already used by another MySQL/XAMPP service, start the stack with a different host port:

```powershell
$env:MYSQL_PORT=3307; docker compose up --build
```

Then edit `resources/js/components/TrainingLogin.vue` or `resources/css/app.css`. Vite runs in its own container on port `5173` and hot-reloads the UI.

Stop the containers with:

```powershell
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
