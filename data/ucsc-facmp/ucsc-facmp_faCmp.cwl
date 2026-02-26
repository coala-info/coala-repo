cwlVersion: v1.2
class: CommandLineTool
baseCommand: faCmp
label: ucsc-facmp_faCmp
doc: "Compare two .fa files\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: a_fa
    type: File
    doc: First .fa file
    inputBinding:
      position: 1
  - id: b_fa
    type: File
    doc: Second .fa file
    inputBinding:
      position: 2
  - id: peptide
    type:
      - 'null'
      - boolean
    doc: read as peptide sequences
    inputBinding:
      position: 103
      prefix: -peptide
  - id: soft_mask
    type:
      - 'null'
      - boolean
    doc: "use the soft masking information during the compare\n                Differences
      will be noted if the masking is different."
    inputBinding:
      position: 103
      prefix: -softMask
  - id: sort_name
    type:
      - 'null'
      - boolean
    doc: sort input files by name before comparing
    inputBinding:
      position: 103
      prefix: -sortName
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-facmp:482--h0b57e2e_0
stdout: ucsc-facmp_faCmp.out
