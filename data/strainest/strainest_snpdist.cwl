cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainest
  - snpdist
label: strainest_snpdist
doc: "Compute the Hamming distances between sequences in SNP matrix (in DGRP format).
  Moreover, it returns the distances histogram in HIST.\n\nTool homepage: https://github.com/compmetagen/strainest"
inputs:
  - id: snp_matrix
    type: File
    doc: SNP matrix (in DGRP format)
    inputBinding:
      position: 1
  - id: distance_file
    type: File
    doc: File to store computed distances
    inputBinding:
      position: 2
outputs:
  - id: histogram_file
    type: File
    doc: File to store the distances histogram
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py35_0
