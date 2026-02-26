cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedItemOverlapCount
label: ucsc-beditemoverlapcount
doc: "Count how many items in a BED file overlap each other. Note: The provided help
  text was a system error message; parameters are based on standard tool documentation.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database_or_file
    type: string
    doc: The database name or the path to a BED file.
    inputBinding:
      position: 1
  - id: table
    type:
      - 'null'
      - string
    doc: The table name (if a database was provided as the first argument).
    inputBinding:
      position: 2
  - id: chrom_size
    type:
      - 'null'
      - File
    doc: Use chromosome sizes from the specified file.
    inputBinding:
      position: 103
      prefix: -chromSize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-beditemoverlapcount:482--h0b57e2e_0
stdout: ucsc-beditemoverlapcount.out
