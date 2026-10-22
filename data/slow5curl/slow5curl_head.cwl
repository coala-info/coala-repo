cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5curl
  - head
label: slow5curl_head
doc: "Prints the header for a remote BLOW5 file.\n\nTool homepage: https://github.com/BonsonW/slow5curl"
inputs:
  - id: slow5_file
    type: string
    doc: URL of the remote BLOW5 file
    inputBinding:
      position: 1
stdout: slow5curl_head.out
outputs:
  - id: header
    type: stdout
    doc: Header of the BLOW5 file
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
