cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genePredCheck
label: ucsc-bedtogenepred_genePredCheck
doc: "Validate genePred files, checking for various errors such as overlapping exons,
  invalid coordinates, and consistency with chromosome sizes.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more genePred files to validate.
    inputBinding:
      position: 1
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: Check against chromosome sizes in this file.
    inputBinding:
      position: 102
      prefix: -chromSizes
  - id: db
    type:
      - 'null'
      - string
    doc: Check against this database for chromosome sizes and other info.
    inputBinding:
      position: 102
      prefix: -db
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level.
    default: 1
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtogenepred:482--h0b57e2e_0
stdout: ucsc-bedtogenepred_genePredCheck.out
