cwlVersion: v1.2
class: CommandLineTool
baseCommand: faCmp
label: ucsc-facmp_faCmp
doc: "Compare two .fa files. Exit code 0 if files are the same, 1 if files differ, 255 on an error.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: a_fa
    type: File
    doc: First .fa file
    inputBinding:
      position: 11
  - id: b_fa
    type: File
    doc: Second .fa file
    inputBinding:
      position: 12
  - id: peptide
    type:
      - 'null'
      - boolean
    doc: read as peptide sequences
    inputBinding:
      position: 3
      prefix: -peptide
  - id: soft_mask
    type:
      - 'null'
      - boolean
    doc: "use the soft masking information during the compare\n                Differences
      will be noted if the masking is different."
    inputBinding:
      position: 1
      prefix: -softMask
  - id: sort_name
    type:
      - 'null'
      - boolean
    doc: sort input files by name before comparing
    inputBinding:
      position: 2
      prefix: -sortName
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Differences found between the two files
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-facmp:482--h0b57e2e_0
stdout: ucsc-facmp_faCmp.out
stderr: ucsc-facmp_faCmp.err
successCodes: [0, 1]
