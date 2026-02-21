cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidtron
label: plasmidtron
doc: "The provided text does not contain help information for plasmidtron; it is an
  error log indicating a failure to build or run the container image due to insufficient
  disk space ('no space left on device'). As a result, no arguments could be extracted
  from the input.\n\nTool homepage: https://github.com/sanger-pathogens/plasmidtron"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidtron:0.4.1--py36_1
stdout: plasmidtron.out
