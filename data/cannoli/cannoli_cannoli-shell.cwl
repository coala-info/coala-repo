cwlVersion: v1.2
class: CommandLineTool
baseCommand: cannoli-shell
label: cannoli_cannoli-shell
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it is an error log from a container build process.\n\nTool
  homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_cannoli-shell.out
