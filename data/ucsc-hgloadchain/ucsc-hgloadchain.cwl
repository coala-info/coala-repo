cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadChain
label: ucsc-hgloadchain
doc: "Load a chain file into the database. (Note: The provided help text appears to
  be a container runtime error log and does not contain usage information. Arguments
  listed are based on standard tool documentation.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The database name (e.g., hg38).
    inputBinding:
      position: 1
  - id: track
    type: string
    doc: The track name.
    inputBinding:
      position: 2
  - id: files_chain
    type:
      type: array
      items: File
    doc: The .chain files to load.
    inputBinding:
      position: 3
  - id: no_bin
    type:
      - 'null'
      - boolean
    doc: Don't create bin column.
    inputBinding:
      position: 104
      prefix: -noBin
  - id: sql_table
    type:
      - 'null'
      - File
    doc: Use this .sql file to create the table.
    inputBinding:
      position: 104
      prefix: -sqlTable
  - id: test
    type:
      - 'null'
      - boolean
    doc: Don't actually load database, just see what would happen.
    inputBinding:
      position: 104
      prefix: -test
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadchain:482--h0b57e2e_0
stdout: ucsc-hgloadchain.out
