---
name: gcs-oauth2-boto-plugin
description: The gcs-oauth2-boto-plugin is a specialized authentication handler for the legacy `boto` library's auth plugin framework.
homepage: https://github.com/GoogleCloudPlatform/gcs-oauth2-boto-plugin
---

# gcs-oauth2-boto-plugin

## Overview

The gcs-oauth2-boto-plugin is a specialized authentication handler for the legacy `boto` library's auth plugin framework. It enables applications to access Google Cloud Storage using OAuth 2.0 credentials instead of older HMAC keys. The plugin provides a wrapper around `oauth2client` and includes built-in, thread-safe, and process-safe token caching to optimize performance and avoid frequent re-authentication.

## Configuration and Usage

### Credential Precedence
When providing a Client ID and Secret, the plugin evaluates sources in the following order:
1.  The `.boto` configuration file.
2.  Environment variables: `OAUTH2_CLIENT_ID` and `OAUTH2_CLIENT_SECRET`.
3.  Programmatic fallback via the `SetFallbackClientIdAndSecret(client_id, client_secret)` function.

### Service Account Integration
Service accounts are supported through key files. The plugin attempts to parse the file as JSON first, falling back to the legacy `.p12` format if JSON parsing fails.

### Concurrency Management
By default, the plugin uses `threading.Lock` for token caching. In multi-process environments (e.g., using the `multiprocessing` module), you must switch to a process-safe lock to prevent cache corruption:

```python
import multiprocessing
from gcs_oauth2_boto_plugin import SetLock

SetLock(multiprocessing.Manager().Lock())
```

### Testing the Integration
To verify that the plugin and credentials are functioning correctly without writing a full application, run the internal test module:

```bash
export PYTHONPATH="."
python -m gcs_oauth2_boto_plugin.test_oauth2_client
```

## Expert Tips and Best Practices

*   **Python Version Compatibility**: Be aware that this plugin may encounter issues on Python 3.12 and higher due to the removal of legacy modules it depends on. For modern projects, migrating to `google-cloud-storage` (which uses `google-auth`) is recommended over using `boto` with this plugin.
*   **Token Caching**: The plugin automatically handles token expiration and refreshing. If you encounter "401 Unauthorized" errors despite correct credentials, check if the local environment has write permissions to the temporary directory where tokens are cached.
*   **Dependency Management**: If installing manually for development rather than via PyPI, ensure all dependencies in `requirements.txt` (specifically `oauth2client`, `six`, and `rsa`) are present in your environment.

## Reference documentation
- [Main Repository README](./references/github_com_GoogleCloudPlatform_gcs-oauth2-boto-plugin.md)
- [Known Issues and Compatibility](./references/github_com_GoogleCloudPlatform_gcs-oauth2-boto-plugin_issues.md)