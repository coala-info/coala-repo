cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pydamage
  - binplot
label: pydamage_binplot
doc: "Plot Damage patterns for a given bin fasta file\n\nTool homepage: https://github.com/maxibor/pydamage"
inputs:
  - id: csv
    type: File
    doc: path to PyDamage result file
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: path to bin fasta file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
stdout: pydamage_binplot.out
