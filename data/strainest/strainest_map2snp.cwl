cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainest
  - map2snp
label: strainest_map2snp
doc: "Build the SNP matrix in DGRP format.\n\nTool homepage: https://github.com/compmetagen/strainest"
inputs:
  - id: reference
    type: File
    doc: Reference genome file
    inputBinding:
      position: 1
  - id: mapped
    type: File
    doc: Mapped genome file
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: Output SNP matrix file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py35_0
