cwlVersion: v1.2
class: CommandLineTool
baseCommand: ndg_httpclient
label: ndg-httpsclient
doc: "A HTTP/HTTPS client tool based on PyOpenSSL to fetch resources, supporting certificate-based
  authentication.\n\nTool homepage: https://github.com/cedadev/ndg_httpsclient"
inputs:
  - id: url
    type: string
    doc: The URL to fetch
    inputBinding:
      position: 1
  - id: ca_certificate
    type:
      - 'null'
      - File
    doc: CA certificate file
    inputBinding:
      position: 102
      prefix: --ca-certificate
  - id: certificate
    type:
      - 'null'
      - File
    doc: Certificate file
    inputBinding:
      position: 102
      prefix: --certificate
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug information
    inputBinding:
      position: 102
      prefix: --debug
  - id: private_key
    type:
      - 'null'
      - File
    doc: Private key file
    inputBinding:
      position: 102
      prefix: --private-key
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ndg-httpsclient:0.4.2--py36_0
stdout: ndg-httpsclient.out
