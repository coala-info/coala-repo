cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli
  - magicBlast
label: cannoli_magicBlast
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or extract the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_magicBlast.out
