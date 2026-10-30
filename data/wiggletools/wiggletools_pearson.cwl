cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_pearson
doc: "Pearson correlation between two tracks across all their points (statistic pearson).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: pearson
inputs:
  - id: first_file
    type: File
    doc: First track.
    inputBinding:
      position: 2
  - id: second_file
    type: File
    doc: Second track.
    inputBinding:
      position: 3
stdout: pearson.txt
outputs:
  - id: result
    type: stdout
    doc: The statistic, printed as a single number.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
