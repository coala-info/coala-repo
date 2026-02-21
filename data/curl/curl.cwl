cwlVersion: v1.2
class: CommandLineTool
label: curl
doc: "Transfer data from or to a server\n\nTool homepage: https://github.com/curl/curl"
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/curl:7.80.0
baseCommand: curl
inputs:
  - id: url
    type: string
    doc: URL to interact with
    inputBinding:
      position: 1
  - id: data
    type: string?
    doc: HTTP POST data
    inputBinding:
      position: 102
      prefix: --data
  - id: fail
    type: boolean?
    doc: Fail silently (no output at all) on HTTP errors
    inputBinding:
      position: 102
      prefix: --fail
  - id: include
    type: boolean?
    doc: Include protocol response headers in the output
    inputBinding:
      position: 102
      prefix: --include
  - id: silent
    type: boolean?
    doc: Silent mode
    inputBinding:
      position: 102
      prefix: --silent
  - id: upload_file
    type: File?
    doc: Transfer local FILE to destination
    inputBinding:
      position: 102
      prefix: --upload-file
  - id: user
    type: string?
    doc: Server user and password
    inputBinding:
      position: 102
      prefix: --user
  - id: user_agent
    type: string?
    doc: Send User-Agent <name> to server
    inputBinding:
      position: 102
      prefix: --user-agent
  - id: verbose
    type: boolean?
    doc: Make the operation more talkative
    inputBinding:
      position: 102
      prefix: --verbose
  - id: output_filename
    type: string?
    doc: Name of the file to write the output to

outputs:
  - id: output_file
    type: stdout

stdout: $(inputs.output_filename || 'curl_output.txt')
successCodes: [0, 6]