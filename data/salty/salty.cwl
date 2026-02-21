cwlVersion: v1.2
class: CommandLineTool
baseCommand: salty
label: salty
doc: "A tool for protein structure analysis (Note: The provided text is a container
  build log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://github.com/LanLab/salty"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salty:1.0.6--pyhdfd78af_0
stdout: salty.out
