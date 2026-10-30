cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_ndpearson
doc: "Pearson correlation between two sets of tracks, computed over all pairs of the multiplexed inputs (statistic ndpearson).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: ndpearson
  - position: 3
    valueFrom: ':'
inputs:
  - id: group1_files
    type: File[]
    doc: First set of tracks (the sets are separated by ':').
    inputBinding:
      position: 2
  - id: group2_files
    type: File[]
    doc: Second set of tracks.
    inputBinding:
      position: 4
stdout: ndpearson.txt
outputs:
  - id: result
    type: stdout
    doc: The statistic, printed as a single number.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
