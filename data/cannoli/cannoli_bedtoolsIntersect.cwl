cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli
  - bedtoolsIntersect
label: cannoli_bedtoolsIntersect
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding a failed container build due to insufficient disk
  space.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_bedtoolsIntersect.out
