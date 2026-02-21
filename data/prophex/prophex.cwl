cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophex
label: prophex
doc: "The provided text does not contain help information for the tool 'prophex'.
  It appears to be a log of a failed container build/fetch process.\n\nTool homepage:
  https://github.com/prophyle/prophex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophex:0.1.1--h577a1d6_6
stdout: prophex.out
