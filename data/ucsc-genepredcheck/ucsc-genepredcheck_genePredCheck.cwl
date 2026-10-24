cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredCheck
label: ucsc-genepredcheck_genePredCheck
doc: "validate genePred files or tables\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: file_tbl
    type:
      type: array
      items: File
    doc: genePred file(s) to check
    inputBinding:
      position: 1
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: use chrom sizes from tab separated file (name,size) instead of from 
      chromInfo table in specified db.
    inputBinding:
      position: 102
      prefix: -chromSizes=
      separate: false
  - id: database
    type:
      - 'null'
      - string
    doc: If specified, then this database is used to get chromosome sizes, and 
      perhaps the table to check.
    inputBinding:
      position: 102
      prefix: -db=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: summary
    type: stderr
    doc: Check summary (genePredCheck writes the checked and failed counts to stderr)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredcheck:482--h0b57e2e_0
stdout: ucsc-genepredcheck_genePredCheck.out
stderr: ucsc-genepredcheck_genePredCheck.err
