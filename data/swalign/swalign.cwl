cwlVersion: v1.2
class: CommandLineTool
baseCommand: swalign
label: swalign
doc: "The provided text does not contain help information for swalign; it is a log
  of a failed container build process.\n\nTool homepage: https://github.com/mbreese/swalign/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swalign:0.3.7--pyhdfd78af_0
stdout: swalign.out
