cwlVersion: v1.2
class: CommandLineTool
baseCommand: biokit
label: biokit
doc: "Bioinformatic toolkit for analysis of genomic and transcriptomic data (Note:
  The provided text contains only system error messages and no help documentation;
  therefore, no arguments could be extracted).\n\nTool homepage: http://pypi.python.org/pypi/biokit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biokit:0.5.0--pyh5e36f6f_0
stdout: biokit.out
