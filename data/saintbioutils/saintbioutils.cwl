cwlVersion: v1.2
class: CommandLineTool
baseCommand: saintbioutils
label: saintbioutils
doc: "A collection of bioinformatics utility tools. (Note: The provided text contains
  system logs and error messages rather than command-line help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/HobnobMancer/saintBioutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/saintbioutils:0.0.25--pyh7cba7a3_0
stdout: saintbioutils.out
