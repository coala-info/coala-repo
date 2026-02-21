cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs
label: tracs
doc: "The provided text does not contain help information or usage instructions for
  the tool 'tracs'. It appears to be a log of a failed container build process due
  to insufficient disk space.\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
stdout: tracs.out
