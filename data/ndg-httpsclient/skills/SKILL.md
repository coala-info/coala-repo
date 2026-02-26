---
name: ndg-httpsclient
description: ndg-httpsclient provides an enhanced HTTPS client for Python that supports peer verification and Subject Alternative Names using PyOpenSSL. Use when user asks to fetch resources via HTTPS, perform mutual TLS authentication with client certificates, or verify server certificates with fine-grained SSL control.
homepage: https://github.com/cedadev/ndg_httpsclient
---


# ndg-httpsclient

## Overview
The `ndg-httpsclient` tool provides an enhanced HTTPS client for Python's `http.client` and `urllib` modules by leveraging PyOpenSSL. It is particularly useful for legacy Python environments or specific security requirements where full peer verification and proper handling of Subject Alternative Names (SAN) in SSL certificates are mandatory. It includes both a programmatic API and a command-line utility for fetching resources securely.

## Command Line Usage
The package installs a command-line script, typically named `ndg_httpclient`, used for fetching data via HTTPS with fine-grained SSL control.

### Basic GET Request
To fetch a URL and print the output to stdout:
```bash
ndg_httpclient https://example.com/api/data
```

### Using Client Certificates
For mutual TLS (mTLS) authentication, provide the certificate and private key:
```bash
ndg_httpclient -c ./credentials.pem -k ./private_key.pem https://secure-service.local
```
*Note: If the private key is contained within the certificate file, you only need to provide the `-c` option.*

### Certificate Verification
By default, the tool attempts to verify the server's certificate. You can specify a directory containing trusted CA certificates:
```bash
ndg_httpclient -t /etc/ssl/certs https://example.com
```

To disable peer verification (not recommended for production):
```bash
ndg_httpclient -n https://example.com
```

### POSTing Data
To send data to a server, point the tool to a file containing the POST body:
```bash
ndg_httpclient -p ./request_body.json https://example.com/api/submit
```

### Saving Output
To save the response directly to a file instead of printing to stdout:
```bash
ndg_httpclient -f output.dat https://example.com/large-file
```

## Expert Tips
- **Debugging**: Use the `-d` or `--debug` flag to see detailed information about the SSL handshake and HTTP headers. This is essential for troubleshooting certificate chain issues.
- **SAN Support**: This tool is a primary choice when dealing with certificates that use Subject Alternative Names which might not be correctly parsed by older Python `ssl` standard library versions.
- **Environment Variables**: The tool defaults to looking for `credentials.pem` in the `$HOME` directory if no certificate path is provided.
- **Dependencies**: Ensure `pyasn1` is installed alongside `ndg-httpsclient`; it is required for correct SSL verification when using Subject Alternative Names.

## Reference documentation
- [ndg_httpsclient README](./references/github_com_cedadev_ndg_httpsclient.md)