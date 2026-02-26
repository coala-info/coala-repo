cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgsqldump
label: ucsc-hgsqldump_hgsqldump
doc: "Execute mysqldump using passwords from .hg.conf\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: database
    type: string
    doc: Database to dump
    inputBinding:
      position: 1
  - id: tables
    type:
      - 'null'
      - type: array
        items: string
    doc: Tables to dump
    inputBinding:
      position: 2
  - id: all_databases
    type:
      - 'null'
      - boolean
    doc: Dump all databases
    inputBinding:
      position: 103
      prefix: --all-databases
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output
    inputBinding:
      position: 103
      prefix: --compress
  - id: databases
    type:
      - 'null'
      - boolean
    doc: Dump specified databases
    inputBinding:
      position: 103
      prefix: --databases
  - id: tab
    type:
      - 'null'
      - Directory
    doc: Directory for tab-separated output files
    inputBinding:
      position: 103
      prefix: --tab
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgsqldump:482--h0b57e2e_0
stdout: ucsc-hgsqldump_hgsqldump.out
