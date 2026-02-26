cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clsify
  - web
label: clsify_web
doc: "Start the clsify web server\n\nTool homepage: https://github.com/holtgrewe/clsify"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Whether or not to enable debugging.
    inputBinding:
      position: 101
      prefix: --debug
  - id: host
    type:
      - 'null'
      - string
    doc: Server host
    inputBinding:
      position: 101
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: Server port
    inputBinding:
      position: 101
      prefix: --port
  - id: public_url_prefix
    type:
      - 'null'
      - string
    doc: The prefix that this app will be served under (e.g., if behind a 
      reverse proxy.)
    inputBinding:
      position: 101
      prefix: --public-url-prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clsify:0.1.1--py_0
stdout: clsify_web.out
