cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju2table
label: kaiju_kaiju2table
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run the container image due to insufficient
  disk space.\n\nTool homepage: https://kaiju.binf.ku.dk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju2table.out
