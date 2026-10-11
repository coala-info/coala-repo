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
  - id: certificate
    type:
      - 'null'
      - File
    doc: Certificate file - defaults to $HOME/credentials.pem
    inputBinding:
      position: 102
      prefix: --certificate
  - id: private_key
    type:
      - 'null'
      - File
    doc: Private key file - defaults to the certificate file
    inputBinding:
      position: 102
      prefix: --private-key
  - id: ca_certificate_dir
    type:
      - 'null'
      - Directory
    doc: Trusted CA certificate file directory
    inputBinding:
      position: 102
      prefix: --ca-certificate-dir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug information
    inputBinding:
      position: 102
      prefix: --debug
  - id: post_data_file
    type:
      - 'null'
      - File
    doc: POST data file
    inputBinding:
      position: 102
      prefix: --post-data-file
  - id: fetch
    type:
      - 'null'
      - string
    doc: Output file
    inputBinding:
      position: 102
      prefix: --fetch
  - id: no_verify_peer
    type:
      - 'null'
      - boolean
    doc: Skip verification of peer certificate
    inputBinding:
      position: 102
      prefix: --no-verify-peer
  - id: basicauth
    type:
      - 'null'
      - string
    doc: HTTP authentication credentials, as USER:PASSWD
    inputBinding:
      position: 102
      prefix: --basicauth
  - id: header
    type:
      - 'null'
      - string
    doc: "Add HTTP header to request, as 'HEADER: VALUE'"
    inputBinding:
      position: 102
      prefix: --header
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fetched_file
    type:
      - 'null'
      - File
    doc: Output file written with --fetch
    outputBinding:
      glob: '$(inputs.fetch ? [inputs.fetch] : [])'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ndg-httpsclient:0.4.2--py36_0
stdout: ndg-httpsclient.out
