cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - ping
label: nebulizer_ping
doc: "Sends a request to GALAXY and reports the status of the response and the time
  taken.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: Galaxy instance to ping
    inputBinding:
      position: 1
  - id: count
    type:
      - 'null'
      - int
    doc: if set then stop after sending COUNT requests
    default: send requests forever
    inputBinding:
      position: 102
      prefix: --count
  - id: interval
    type:
      - 'null'
      - float
    doc: set the interval between sending requests in seconds
    default: 5
    inputBinding:
      position: 102
      prefix: --interval
  - id: timeout
    type:
      - 'null'
      - float
    doc: specify timeout limit in seconds when no connection can be made
    inputBinding:
      position: 102
      prefix: --timeout
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_ping.out
