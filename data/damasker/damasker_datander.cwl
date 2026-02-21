cwlVersion: v1.2
class: CommandLineTool
baseCommand: datander
label: damasker_datander
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/thegenemyers/DAMASKER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
stdout: damasker_datander.out
