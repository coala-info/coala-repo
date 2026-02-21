cwlVersion: v1.2
class: CommandLineTool
baseCommand: starcatpy
label: starcatpy
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/immunogenomics/starCAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starcatpy:1.0.9--pyh7e72e81_0
stdout: starcatpy.out
