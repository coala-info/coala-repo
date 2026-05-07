# scrapling CWL Generation Report

## scrapling

### Tool Description
[Errno 2] No such file or directory: 'scrapling'; fallback failed: [Errno 2] No such file or directory: 'scrapling'

### Metadata
- **Docker Image**: pyd4vinci/scrapling
- **Homepage**: https://github.com/D4Vinci/Scrapling
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/scrapling/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/D4Vinci/Scrapling
- **Stars**: N/A
### Generation Failed

[Errno 2] No such file or directory: 'scrapling'; fallback failed: [Errno 2] No such file or directory: 'scrapling'


### Validation Errors

- [Errno 2] No such file or directory: 'scrapling'; fallback failed: [Errno 2] No such file or directory: 'scrapling'



### Original Help Text
```text

```
## extract

### Tool Description
[Errno 2] No such file or directory: 'extract'; fallback failed: [Errno 2] No such file or directory: 'extract'

### Metadata
- **Docker Image**: Not found
- **Homepage**: https://github.com/D4Vinci/Scrapling
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

[Errno 2] No such file or directory: 'extract'; fallback failed: [Errno 2] No such file or directory: 'extract'


### Validation Errors

- [Errno 2] No such file or directory: 'extract'; fallback failed: [Errno 2] No such file or directory: 'extract'



### Original Help Text
```text

```

## scrapling_extract_get

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: pyd4vinci/scrapling
- **Homepage**: https://github.com/D4Vinci/Scrapling
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Building scrapling @ file:///app
      Built scrapling @ file:///app
Uninstalled 1 package in 5ms
Installed 1 package in 0.96ms
Usage: scrapling [OPTIONS] COMMAND [ARGS]...
Try 'scrapling --help' for help.

Error: No such command 'scrapling'.
```

## extract_get

### Tool Description
Perform a GET request and save the content to a file. The output file path can be an HTML file, a Markdown file of the HTML content, or the text content itself. Use file extensions (.html/.md/.txt) respectively.

### Metadata
- **Docker Image**: pyd4vinci/scrapling
- **Homepage**: https://github.com/D4Vinci/Scrapling
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: scrapling extract get [OPTIONS] URL OUTPUT_FILE

  Perform a GET request and save the content to a file.

  The output file path can be an HTML file, a Markdown file of the HTML
  content, or the text content itself. Use file extensions
  (`.html`/`.md`/`.txt`) respectively.

Options:
  -H, --headers TEXT              HTTP headers in format "Key: Value" (can be
                                  used multiple times)
  --cookies TEXT                  Cookies string in format "name1=value1;
                                  name2=value2"
  --timeout INTEGER               Request timeout in seconds (default: 30)
  --proxy TEXT                    Proxy URL in format
                                  "http://username:password@host:port"
  -s, --css-selector TEXT         CSS selector to extract specific content
                                  from the page. It returns all matches.
  -p, --params TEXT               Query parameters in format "key=value" (can
                                  be used multiple times)
  --follow-redirects / --no-follow-redirects
                                  Whether to follow redirects (default: True)
  --verify / --no-verify          Whether to verify SSL certificates (default:
                                  True)
  --impersonate TEXT              Browser to impersonate. Can be a single
                                  browser (e.g., chrome) or comma-separated
                                  list for random selection (e.g.,
                                  chrome,firefox,safari).
  --stealthy-headers / --no-stealthy-headers
                                  Use stealthy browser headers (default: True)
  --ai-targeted                   Extract only main content and sanitize
                                  hidden elements for AI consumption (default:
                                  False)
  --help                          Show this message and exit.
   Building scrapling @ file:///app
      Built scrapling @ file:///app
Uninstalled 1 package in 5ms
Installed 1 package in 2ms
```

## extract_post

### Tool Description
Perform a POST request and save the content to a file. The output file path can be an HTML file, a Markdown file of the HTML content, or the text content itself.

### Metadata
- **Docker Image**: pyd4vinci/scrapling
- **Homepage**: https://github.com/D4Vinci/Scrapling
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: scrapling extract post [OPTIONS] URL OUTPUT_FILE

  Perform a POST request and save the content to a file.

  The output file path can be an HTML file, a Markdown file of the HTML
  content, or the text content itself. Use file extensions
  (`.html`/`.md`/`.txt`) respectively.

Options:
  -d, --data TEXT                 Form data to include in the request body (as
                                  string, ex: "param1=value1&param2=value2")
  -j, --json TEXT                 JSON data to include in the request body (as
                                  string)
  -H, --headers TEXT              HTTP headers in format "Key: Value" (can be
                                  used multiple times)
  --cookies TEXT                  Cookies string in format "name1=value1;
                                  name2=value2"
  --timeout INTEGER               Request timeout in seconds (default: 30)
  --proxy TEXT                    Proxy URL in format
                                  "http://username:password@host:port"
  -s, --css-selector TEXT         CSS selector to extract specific content
                                  from the page. It returns all matches.
  -p, --params TEXT               Query parameters in format "key=value" (can
                                  be used multiple times)
  --follow-redirects / --no-follow-redirects
                                  Whether to follow redirects (default: True)
  --verify / --no-verify          Whether to verify SSL certificates (default:
                                  True)
  --impersonate TEXT              Browser to impersonate. Can be a single
                                  browser (e.g., chrome) or comma-separated
                                  list for random selection (e.g.,
                                  chrome,firefox,safari).
  --stealthy-headers / --no-stealthy-headers
                                  Use stealthy browser headers (default: True)
  --ai-targeted                   Extract only main content and sanitize
                                  hidden elements for AI consumption (default:
                                  False)
  --help                          Show this message and exit.
   Building scrapling @ file:///app
      Built scrapling @ file:///app
Uninstalled 1 package in 5ms
Installed 1 package in 1ms
```

## extract_put

### Tool Description
Perform a PUT request and save the content to a file. The output file path can be an HTML file, a Markdown file of the HTML content, or the text content itself.

### Metadata
- **Docker Image**: pyd4vinci/scrapling
- **Homepage**: https://github.com/D4Vinci/Scrapling
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: scrapling extract put [OPTIONS] URL OUTPUT_FILE

  Perform a PUT request and save the content to a file.

  The output file path can be an HTML file, a Markdown file of the HTML
  content, or the text content itself. Use file extensions
  (`.html`/`.md`/`.txt`) respectively.

Options:
  -d, --data TEXT                 Form data to include in the request body (as
                                  string, ex: "param1=value1&param2=value2")
  -j, --json TEXT                 JSON data to include in the request body (as
                                  string)
  -H, --headers TEXT              HTTP headers in format "Key: Value" (can be
                                  used multiple times)
  --cookies TEXT                  Cookies string in format "name1=value1;
                                  name2=value2"
  --timeout INTEGER               Request timeout in seconds (default: 30)
  --proxy TEXT                    Proxy URL in format
                                  "http://username:password@host:port"
  -s, --css-selector TEXT         CSS selector to extract specific content
                                  from the page. It returns all matches.
  -p, --params TEXT               Query parameters in format "key=value" (can
                                  be used multiple times)
  --follow-redirects / --no-follow-redirects
                                  Whether to follow redirects (default: True)
  --verify / --no-verify          Whether to verify SSL certificates (default:
                                  True)
  --impersonate TEXT              Browser to impersonate. Can be a single
                                  browser (e.g., chrome) or comma-separated
                                  list for random selection (e.g.,
                                  chrome,firefox,safari).
  --stealthy-headers / --no-stealthy-headers
                                  Use stealthy browser headers (default: True)
  --ai-targeted                   Extract only main content and sanitize
                                  hidden elements for AI consumption (default:
                                  False)
  --help                          Show this message and exit.
   Building scrapling @ file:///app
      Built scrapling @ file:///app
Uninstalled 1 package in 4ms
Installed 1 package in 1ms
```

## extract_delete

### Tool Description
Perform a DELETE request and save the content to a file. The output file path can be an HTML file, a Markdown file of the HTML content, or the text content itself. Use file extensions (.html/.md/.txt) respectively.

### Metadata
- **Docker Image**: pyd4vinci/scrapling
- **Homepage**: https://github.com/D4Vinci/Scrapling
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: scrapling extract delete [OPTIONS] URL OUTPUT_FILE

  Perform a DELETE request and save the content to a file.

  The output file path can be an HTML file, a Markdown file of the HTML
  content, or the text content itself. Use file extensions
  (`.html`/`.md`/`.txt`) respectively.

Options:
  -H, --headers TEXT              HTTP headers in format "Key: Value" (can be
                                  used multiple times)
  --cookies TEXT                  Cookies string in format "name1=value1;
                                  name2=value2"
  --timeout INTEGER               Request timeout in seconds (default: 30)
  --proxy TEXT                    Proxy URL in format
                                  "http://username:password@host:port"
  -s, --css-selector TEXT         CSS selector to extract specific content
                                  from the page. It returns all matches.
  -p, --params TEXT               Query parameters in format "key=value" (can
                                  be used multiple times)
  --follow-redirects / --no-follow-redirects
                                  Whether to follow redirects (default: True)
  --verify / --no-verify          Whether to verify SSL certificates (default:
                                  True)
  --impersonate TEXT              Browser to impersonate. Can be a single
                                  browser (e.g., chrome) or comma-separated
                                  list for random selection (e.g.,
                                  chrome,firefox,safari).
  --stealthy-headers / --no-stealthy-headers
                                  Use stealthy browser headers (default: True)
  --ai-targeted                   Extract only main content and sanitize
                                  hidden elements for AI consumption (default:
                                  False)
  --help                          Show this message and exit.
   Building scrapling @ file:///app
      Built scrapling @ file:///app
Uninstalled 1 package in 4ms
Installed 1 package in 1ms
```

## extract_fetch

### Tool Description
Use DynamicFetcher to fetch content with browser automation. The output file path can be an HTML file, a Markdown file of the HTML content, or the text content itself. Use file extensions (.html/.md/.txt) respectively.

### Metadata
- **Docker Image**: pyd4vinci/scrapling
- **Homepage**: https://github.com/D4Vinci/Scrapling
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: scrapling extract fetch [OPTIONS] URL OUTPUT_FILE

  Use DynamicFetcher to fetch content with browser automation.

  The output file path can be an HTML file, a Markdown file of the HTML
  content, or the text content itself. Use file extensions
  (`.html`/`.md`/`.txt`) respectively.

Options:
  --block-ads / --no-block-ads    Block requests to known ad and tracker
                                  domains (default: False)
  --dns-over-https / --no-dns-over-https
                                  Route DNS through Cloudflare's DoH to
                                  prevent DNS leaks when using proxies
                                  (default: False)
  --headless / --no-headless      Run browser in headless mode (default: True)
  --disable-resources / --enable-resources
                                  Drop unnecessary resources for speed boost
                                  (default: False)
  --network-idle / --no-network-idle
                                  Wait for network idle (default: False)
  --timeout INTEGER               Timeout in milliseconds (default: 30000)
  --wait INTEGER                  Additional wait time in milliseconds after
                                  page load (default: 0)
  -s, --css-selector TEXT         CSS selector to extract specific content
                                  from the page. It returns all matches.
  --wait-selector TEXT            CSS selector to wait for before proceeding
  --locale TEXT                   Specify user locale. Defaults to the system
                                  default locale.
  --real-chrome / --no-real-chrome
                                  If you have a Chrome browser installed on
                                  your device, enable this, and the Fetcher
                                  will launch an instance of your browser and
                                  use it. (default: False)
  --proxy TEXT                    Proxy URL in format
                                  "http://username:password@host:port"
  -H, --extra-headers TEXT        Extra headers in format "Key: Value" (can be
                                  used multiple times)
  --ai-targeted                   Extract only main content and sanitize
                                  hidden elements for AI consumption (default:
                                  False)
  --help                          Show this message and exit.
   Building scrapling @ file:///app
      Built scrapling @ file:///app
Uninstalled 1 package in 4ms
Installed 1 package in 0.94ms
```

## extract_stealthy-fetch

### Tool Description
Use StealthyFetcher to fetch content with advanced stealth features. The output file path can be an HTML file, a Markdown file of the HTML content, or the text content itself.

### Metadata
- **Docker Image**: pyd4vinci/scrapling
- **Homepage**: https://github.com/D4Vinci/Scrapling
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: scrapling extract stealthy-fetch [OPTIONS] URL OUTPUT_FILE

  Use StealthyFetcher to fetch content with advanced stealth features.

  The output file path can be an HTML file, a Markdown file of the HTML
  content, or the text content itself. Use file extensions
  (`.html`/`.md`/`.txt`) respectively.

Options:
  --block-webrtc / --allow-webrtc
                                  Block WebRTC entirely (default: False)
  --solve-cloudflare / --no-solve-cloudflare
                                  Solve Cloudflare challenges (default: False)
  --allow-webgl / --block-webgl   Allow WebGL (default: True)
  --hide-canvas / --show-canvas   Add noise to canvas operations (default:
                                  False)
  --block-ads / --no-block-ads    Block requests to known ad and tracker
                                  domains (default: False)
  --dns-over-https / --no-dns-over-https
                                  Route DNS through Cloudflare's DoH to
                                  prevent DNS leaks when using proxies
                                  (default: False)
  --headless / --no-headless      Run browser in headless mode (default: True)
  --disable-resources / --enable-resources
                                  Drop unnecessary resources for speed boost
                                  (default: False)
  --network-idle / --no-network-idle
                                  Wait for network idle (default: False)
  --timeout INTEGER               Timeout in milliseconds (default: 30000)
  --wait INTEGER                  Additional wait time in milliseconds after
                                  page load (default: 0)
  -s, --css-selector TEXT         CSS selector to extract specific content
                                  from the page. It returns all matches.
  --wait-selector TEXT            CSS selector to wait for before proceeding
  --locale TEXT                   Specify user locale. Defaults to the system
                                  default locale.
  --real-chrome / --no-real-chrome
                                  If you have a Chrome browser installed on
                                  your device, enable this, and the Fetcher
                                  will launch an instance of your browser and
                                  use it. (default: False)
  --proxy TEXT                    Proxy URL in format
                                  "http://username:password@host:port"
  -H, --extra-headers TEXT        Extra headers in format "Key: Value" (can be
                                  used multiple times)
  --ai-targeted                   Extract only main content and sanitize
                                  hidden elements for AI consumption (default:
                                  False)
  --help                          Show this message and exit.
   Building scrapling @ file:///app
      Built scrapling @ file:///app
Uninstalled 1 package in 7ms
Installed 1 package in 1ms
```
