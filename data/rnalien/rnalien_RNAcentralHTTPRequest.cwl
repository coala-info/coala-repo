cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAcentralHTTPRequest
label: rnalien_RNAcentralHTTPRequest
doc: "RNAcentralHTTPRequest queries the RNAcentral web service with an input sequence.\n\nTool homepage: https://github.com/eggzilla/RNAlien"
inputs:
  - id: input_sequence
    type: string
    doc: input sequence
    inputBinding:
      position: 101
      prefix: -i
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Loud verbosity
    inputBinding:
      position: 101
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet verbosity
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnalien:1.8.0--1
stdout: rnalien_RNAcentralHTTPRequest.out
