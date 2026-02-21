cwlVersion: v1.2
class: CommandLineTool
baseCommand: barrnap
label: barrnap
doc: "The provided text does not contain help information for barrnap; it is an error
  log indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/tseemann/barrnap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barrnap:0.9--0
stdout: barrnap.out
