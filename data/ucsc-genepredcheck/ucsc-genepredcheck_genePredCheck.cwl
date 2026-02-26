cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredCheck
label: ucsc-genepredcheck_genePredCheck
doc: "validate genePred files or tables\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: file_tbl
    type:
      type: array
      items: string
    doc: File or table to check
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
      prefix: --chromSizes
  - id: database
    type:
      - 'null'
      - string
    doc: If specified, then this database is used to get chromosome sizes, and 
      perhaps the table to check.
    inputBinding:
      position: 102
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredcheck:482--h0b57e2e_0
stdout: ucsc-genepredcheck_genePredCheck.out
