cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli
  - star
label: cannoli_star
doc: "The provided text does not contain help information for the tool. It contains
  system logs indicating a failure to build a container image due to lack of disk
  space.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_star.out
