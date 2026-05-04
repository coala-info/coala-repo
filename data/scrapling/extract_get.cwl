cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - extract
  - get
label: extract_get
doc: Perform a GET request and save the content to a file. The output file path 
  can be an HTML file, a Markdown file of the HTML content, or the text content 
  itself. Use file extensions (.html/.md/.txt) respectively.
inputs:
  - id: url
    type: string
    doc: URL to perform the GET request on
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: The output file path (.html, .md, or .txt)
    inputBinding:
      position: 2
  - id: headers
    type:
      - 'null'
      - type: array
        items: string
    doc: 'HTTP headers in format "Key: Value" (can be used multiple times)'
    inputBinding:
      position: 103
      prefix: --headers
  - id: cookies
    type:
      - 'null'
      - string
    doc: Cookies string in format "name1=value1; name2=value2"
    inputBinding:
      position: 103
      prefix: --cookies
  - id: timeout
    type:
      - 'null'
      - int
    doc: Request timeout in seconds
    inputBinding:
      position: 103
      prefix: --timeout
  - id: proxy
    type:
      - 'null'
      - string
    doc: Proxy URL in format "http://username:password@host:port"
    inputBinding:
      position: 103
      prefix: --proxy
  - id: css_selector
    type:
      - 'null'
      - string
    doc: CSS selector to extract specific content from the page. It returns all 
      matches.
    inputBinding:
      position: 103
      prefix: --css-selector
  - id: params
    type:
      - 'null'
      - type: array
        items: string
    doc: Query parameters in format "key=value" (can be used multiple times)
    inputBinding:
      position: 103
      prefix: --params
  - id: follow_redirects
    type:
      - 'null'
      - boolean
    doc: Whether to follow redirects
    inputBinding:
      position: 103
      prefix: --follow-redirects
  - id: verify
    type:
      - 'null'
      - boolean
    doc: Whether to verify SSL certificates
    inputBinding:
      position: 103
      prefix: --verify
  - id: impersonate
    type:
      - 'null'
      - string
    doc: Browser to impersonate. Can be a single browser (e.g., chrome) or 
      comma-separated list for random selection (e.g., chrome,firefox,safari).
    inputBinding:
      position: 103
      prefix: --impersonate
  - id: stealthy_headers
    type:
      - 'null'
      - boolean
    doc: Use stealthy browser headers
    inputBinding:
      position: 103
      prefix: --stealthy-headers
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
