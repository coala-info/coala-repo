cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkHgFindSpec
label: ucsc-checkhgfindspec
doc: "Check that hgFindSpec table is okay for a given database.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The database to check (e.g., hg19, mm10).
    inputBinding:
      position: 1
  - id: spec_table
    type:
      - 'null'
      - string
    doc: Optional specification table name.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-checkhgfindspec:482--h0b57e2e_0
stdout: ucsc-checkhgfindspec.out
