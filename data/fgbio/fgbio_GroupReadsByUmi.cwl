cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - GroupReadsByUmi
label: fgbio_GroupReadsByUmi
doc: "Groups reads by UMI (Unique Molecular Identifier). Note: The provided help text
  contains a system error message and does not list specific arguments.\n\nTool homepage:
  https://github.com/fulcrumgenomics/fgbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio_GroupReadsByUmi.out
