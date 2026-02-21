---
name: intervals
description: Intervals (based on the CookieCloud protocol) provides a secure bridge for synchronizing browser session data between different clients or into automated environments.
homepage: https://github.com/easychen/CookieCloud
---

# intervals

## Overview
Intervals (based on the CookieCloud protocol) provides a secure bridge for synchronizing browser session data between different clients or into automated environments. By utilizing a self-hosted relay server and client-side AES encryption, it allows for the programmatic retrieval of cookies and local storage without exposing sensitive data to third-party providers. This skill focuses on server deployment, API communication, and the cryptographic procedures required to handle synced data.

## Server Deployment
The most efficient way to host the synchronization backend is via Docker.

### Standard Deployment
Run the server on the default port (8088):
`docker run -p=8088:8088 easychen/cookiecloud:latest`

### Subdirectory Configuration
If hosting behind a reverse proxy or on a specific path, use the `API_ROOT` environment variable:
`docker run -e API_ROOT=/my-path -p=8088:8088 easychen/cookiecloud:latest`

### Persistent Storage
Mount a volume to ensure data persists across container restarts:
`docker run -p=8088:8088 -v $(pwd)/data:/data/api/data easychen/cookiecloud:latest`

## API Interaction
The server provides two primary endpoints for data management.

### Uploading Data
**Endpoint:** `POST /update`
**Parameters:**
- `uuid`: Unique identifier for the client.
- `encrypted`: The AES-encrypted data string.

### Downloading Data
**Endpoint:** `POST/GET /get/:uuid`
**Parameters:**
- `password`: (Optional) If provided, the server attempts to decrypt the content before returning. If omitted, the raw encrypted string is returned.

## Cryptographic Implementation
To programmatically access cookies, you must implement the specific encryption/decryption logic used by the protocol.

### Key Generation
1. Concatenate the `uuid` and `password` (e.g., `uuid-password`).
2. Generate an MD5 hash of the concatenated string.
3. Take the first 16 characters of the MD5 hash as the AES key.

### Decryption Procedure
- **Algorithm:** AES-128-CBC.
- **Input:** The `encrypted` string from the `/get` endpoint.
- **Output:** A JSON string containing `{ "cookie_data": [...], "local_storage_data": [...] }`.

### Node.js Decryption Example
```javascript
const CryptoJS = require('crypto-js');
const the_key = CryptoJS.MD5(uuid + '-' + password).toString().substring(0, 16);
const decrypted = CryptoJS.AES.decrypt(encrypted, the_key).toString(CryptoJS.enc.Utf8);
const data = JSON.parse(decrypted);
```

## Best Practices
- **Self-Hosting:** Always use a self-hosted instance for production data to maintain control over the end-to-end encryption keys.
- **Domain Filtering:** When using the browser extension, configure specific domain keywords to limit synchronization to necessary sites only, reducing the payload size and security surface.
- **Headless Integration:** Use the API to inject cookies into headless browser contexts (like Playwright or Puppeteer) to bypass login flows in automated scripts.

## Reference documentation
- [CookieCloud Main README](./references/github_com_easychen_CookieCloud.md)
- [API Directory Details](./references/github_com_easychen_CookieCloud_tree_master_api.md)