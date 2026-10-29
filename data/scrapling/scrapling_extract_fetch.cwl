cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - extract
  - fetch
label: scrapling_extract_fetch
doc: "Use StealthyFetcher to fetch content with advanced stealth features. The output file path can be an HTML file, a Markdown file of the HTML content, or the text content itself. Use file extensions (.html/.md/.txt) respectively.\n\nTool homepage: https://github.com/D4Vinci/Scrapling"
inputs:
  - id: url
    type: string
    doc: URL to fetch
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: The output file path (.html, .md, or .txt)
    inputBinding:
      position: 2
  - id: block_webrtc
    type:
      - 'null'
      - boolean
    doc: "Block WebRTC entirely (default: False)"
    inputBinding:
      position: 103
      prefix: --block-webrtc
  - id: allow_webrtc
    type:
      - 'null'
      - boolean
    doc: "Allow WebRTC"
    inputBinding:
      position: 103
      prefix: --allow-webrtc
  - id: solve_cloudflare
    type:
      - 'null'
      - boolean
    doc: "Solve Cloudflare challenges (default: False)"
    inputBinding:
      position: 103
      prefix: --solve-cloudflare
  - id: no_solve_cloudflare
    type:
      - 'null'
      - boolean
    doc: "Do not solve Cloudflare challenges"
    inputBinding:
      position: 103
      prefix: --no-solve-cloudflare
  - id: allow_webgl
    type:
      - 'null'
      - boolean
    doc: "Allow WebGL (default: True)"
    inputBinding:
      position: 103
      prefix: --allow-webgl
  - id: block_webgl
    type:
      - 'null'
      - boolean
    doc: "Block WebGL"
    inputBinding:
      position: 103
      prefix: --block-webgl
  - id: hide_canvas
    type:
      - 'null'
      - boolean
    doc: "Add noise to canvas operations (default: False)"
    inputBinding:
      position: 103
      prefix: --hide-canvas
  - id: show_canvas
    type:
      - 'null'
      - boolean
    doc: "Do not add noise to canvas operations"
    inputBinding:
      position: 103
      prefix: --show-canvas
  - id: block_ads
    type:
      - 'null'
      - boolean
    doc: "Block requests to known ad and tracker domains (default: False)"
    inputBinding:
      position: 103
      prefix: --block-ads
  - id: no_block_ads
    type:
      - 'null'
      - boolean
    doc: "Do not block requests to known ad and tracker domains"
    inputBinding:
      position: 103
      prefix: --no-block-ads
  - id: dns_over_https
    type:
      - 'null'
      - boolean
    doc: "Route DNS through Cloudflare's DoH to prevent DNS leaks when using proxies (default: False)"
    inputBinding:
      position: 103
      prefix: --dns-over-https
  - id: no_dns_over_https
    type:
      - 'null'
      - boolean
    doc: "Do not route DNS through DoH"
    inputBinding:
      position: 103
      prefix: --no-dns-over-https
  - id: headless
    type:
      - 'null'
      - boolean
    doc: "Run browser in headless mode (default: True)"
    inputBinding:
      position: 103
      prefix: --headless
  - id: no_headless
    type:
      - 'null'
      - boolean
    doc: "Do not run the browser in headless mode"
    inputBinding:
      position: 103
      prefix: --no-headless
  - id: disable_resources
    type:
      - 'null'
      - boolean
    doc: "Drop unnecessary resources for speed boost (default: False)"
    inputBinding:
      position: 103
      prefix: --disable-resources
  - id: enable_resources
    type:
      - 'null'
      - boolean
    doc: "Keep all resources"
    inputBinding:
      position: 103
      prefix: --enable-resources
  - id: network_idle
    type:
      - 'null'
      - boolean
    doc: "Wait for network idle (default: False)"
    inputBinding:
      position: 103
      prefix: --network-idle
  - id: no_network_idle
    type:
      - 'null'
      - boolean
    doc: "Do not wait for network idle"
    inputBinding:
      position: 103
      prefix: --no-network-idle
  - id: pierce_shadow
    type:
      - 'null'
      - boolean
    doc: "Include open Shadow DOM content (default: False)"
    inputBinding:
      position: 103
      prefix: --pierce-shadow
  - id: no_pierce_shadow
    type:
      - 'null'
      - boolean
    doc: "Do not include open Shadow DOM content"
    inputBinding:
      position: 103
      prefix: --no-pierce-shadow
  - id: timeout
    type:
      - 'null'
      - int
    doc: "Timeout in milliseconds (default: 30000)"
    inputBinding:
      position: 103
      prefix: --timeout
  - id: wait
    type:
      - 'null'
      - int
    doc: "Additional wait time in milliseconds after page load (default: 0)"
    inputBinding:
      position: 103
      prefix: --wait
  - id: css_selector
    type:
      - 'null'
      - string
    doc: "CSS selector to extract specific content from the page. It returns all matches."
    inputBinding:
      position: 103
      prefix: --css-selector
  - id: wait_selector
    type:
      - 'null'
      - string
    doc: "CSS selector to wait for before proceeding"
    inputBinding:
      position: 103
      prefix: --wait-selector
  - id: locale
    type:
      - 'null'
      - string
    doc: "Specify user locale. Defaults to the system default locale."
    inputBinding:
      position: 103
      prefix: --locale
  - id: real_chrome
    type:
      - 'null'
      - boolean
    doc: "If you have a Chrome browser installed on your device, enable this, and the Fetcher will launch an instance of your browser and use it. (default: False)"
    inputBinding:
      position: 103
      prefix: --real-chrome
  - id: no_real_chrome
    type:
      - 'null'
      - boolean
    doc: "Do not use a locally installed Chrome browser"
    inputBinding:
      position: 103
      prefix: --no-real-chrome
  - id: proxy
    type:
      - 'null'
      - string
    doc: "Proxy URL in format \"http://username:password@host:port\""
    inputBinding:
      position: 103
      prefix: --proxy
  - id: extra_headers
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --extra-headers
          separate: true
    doc: 'Extra headers in format "Key: Value" (can be used multiple times)'
    inputBinding:
      position: 103
  - id: executable_path
    type:
      - 'null'
      - string
    doc: "Path to a custom Chromium-compatible browser executable. Falls back to the SCRAPLING_EXECUTABLE_PATH environment variable when not set."
    inputBinding:
      position: 103
      prefix: --executable-path
  - id: ai_targeted
    type:
      - 'null'
      - boolean
    doc: "Extract only main content and sanitize hidden elements for AI consumption (default: False)"
    inputBinding:
      position: 103
      prefix: --ai-targeted
outputs:
  - id: out_output_file
    type: File
    doc: The output file path (.html, .md, or .txt)
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: UV_PROJECT
        envValue: /app
      - envName: UV_NO_SYNC
        envValue: '1'
  - class: DockerRequirement
    dockerPull: pyd4vinci/scrapling
s:url: https://github.com/D4Vinci/Scrapling
$namespaces:
  s: https://schema.org/
