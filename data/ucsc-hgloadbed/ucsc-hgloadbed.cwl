cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadBed
label: ucsc-hgloadbed
doc: "Load a BED file into a database table in the UCSC Genome Browser database.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The name of the database to load into (e.g., hg38).
    inputBinding:
      position: 1
  - id: table
    type: string
    doc: The name of the table to create or append to.
    inputBinding:
      position: 2
  - id: bed_file
    type: File
    doc: The BED file containing the data to be loaded.
    inputBinding:
      position: 3
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append to the existing table.
    inputBinding:
      position: 104
      prefix: -append
  - id: custom
    type:
      - 'null'
      - boolean
    doc: Loading a custom track.
    inputBinding:
      position: 104
      prefix: -custom
  - id: no_bin
    type:
      - 'null'
      - boolean
    doc: Suppress the addition of a bin column.
    inputBinding:
      position: 104
      prefix: -noBin
  - id: not_strict
    type:
      - 'null'
      - boolean
    doc: Don't be strict about BED format.
    inputBinding:
      position: 104
      prefix: -notStrict
  - id: old_table
    type:
      - 'null'
      - boolean
    doc: Don't create a new table; use the existing one.
    inputBinding:
      position: 104
      prefix: -oldTable
  - id: sql_table
    type:
      - 'null'
      - File
    doc: Use the specified SQL file to create the table.
    inputBinding:
      position: 104
      prefix: -sqlTable
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Input is tab-separated.
    inputBinding:
      position: 104
      prefix: -tab
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Path to a directory for temporary files.
    inputBinding:
      position: 104
      prefix: -tmpDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadbed:482--h0b57e2e_1
stdout: ucsc-hgloadbed.out
