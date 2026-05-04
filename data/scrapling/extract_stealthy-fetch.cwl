cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - extract
  - stealthy-fetch
label: extract_stealthy-fetch
doc: Use StealthyFetcher to fetch content with advanced stealth features. The 
  output file path can be an HTML file, a Markdown file of the HTML content, or 
  the text content itself.
inputs:
  - id: url
    type: string
    doc: URL to fetch content from
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output file path (.html, .md, or .txt)
    inputBinding:
      position: 2
  - id: block_webrtc
    type:
      - 'null'
      - boolean
    doc: Block WebRTC entirely
    inputBinding:
      position: 103
      prefix: --block-webrtc
  - id: solve_cloudflare
    type:
      - 'null'
      - boolean
    doc: Solve Cloudflare challenges
    inputBinding:
      position: 103
      prefix: --solve-cloudflare
  - id: allow_webgl
    type:
      - 'null'
      - boolean
    doc: Allow WebGL
    inputBinding:
      position: 103
      prefix: --allow-webgl
  - id: hide_canvas
    type:
      - 'null'
      - boolean
    doc: Add noise to canvas operations
    inputBinding:
      position: 103
      prefix: --hide-canvas
  - id: block_ads
    type:
      - 'null'
      - boolean
    doc: Block requests to known ad and tracker domains
    inputBinding:
      position: 103
      prefix: --block-ads
  - id: dns_over_https
    type:
      - 'null'
      - boolean
    doc: Route DNS through Cloudflare's DoH to prevent DNS leaks when using 
      proxies
    inputBinding:
      position: 103
      prefix: --dns-over-https
  - id: headless
    type:
      - 'null'
      - boolean
    doc: Run browser in headless mode
    inputBinding:
      position: 103
      prefix: --headless
  - id: disable_resources
    type:
      - 'null'
      - boolean
    doc: Drop unnecessary resources for speed boost
    inputBinding:
      position: 103
      prefix: --disable-resources
  - id: network_idle
    type:
      - 'null'
      - boolean
    doc: Wait for network idle
    inputBinding:
      position: 103
      prefix: --network-idle
  - id: timeout
    type:
      - 'null'
      - int
    doc: Timeout in milliseconds
    inputBinding:
      position: 103
      prefix: --timeout
  - id: wait
    type:
      - 'null'
      - int
    doc: Additional wait time in milliseconds after page load
    inputBinding:
      position: 103
      prefix: --wait
  - id: css_selector
    type:
      - 'null'
      - string
    doc: CSS selector to extract specific content from the page. It returns all 
      matches.
    inputBinding:
      position: 103
      prefix: --css-selector
  - id: wait_selector
    type:
      - 'null'
      - string
    doc: CSS selector to wait for before proceeding
    inputBinding:
      position: 103
      prefix: --wait-selector
  - id: locale
    type:
      - 'null'
      - string
    doc: Specify user locale. Defaults to the system default locale.
    inputBinding:
      position: 103
      prefix: --locale
  - id: real_chrome
    type:
      - 'null'
      - boolean
    doc: If you have a Chrome browser installed on your device, enable this, and
      the Fetcher will launch an instance of your browser and use it.
    inputBinding:
      position: 103
      prefix: --real-chrome
  - id: proxy
    type:
      - 'null'
      - string
    doc: Proxy URL in format "http://username:password@host:port"
    inputBinding:
      position: 103
      prefix: --proxy
  - id: extra_headers
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Extra headers in format "Key: Value" (can be used multiple times)'
    inputBinding:
      position: 103
      prefix: --extra-headers
  - id: ai_targeted
    type:
      - 'null'
      - boolean
    doc: Extract only main content and sanitize hidden elements for AI 
      consumption
    inputBinding:
      position: 103
      prefix: --ai-targeted
outputs:
  - id: out_output_file
    type: File
    doc: Output file path (.html, .md, or .txt)
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
