cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadChain
label: ucsc-hgloadchain_hgLoadChain
doc: "Load a generic Chain file into database\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 1
  - id: chrN_track
    type: string
    doc: Name of the chromosome track
    inputBinding:
      position: 2
  - id: chain_file
    type: File
    doc: Chain file to load
    inputBinding:
      position: 3
  - id: include_tname_in_indexes
    type:
      - 'null'
      - boolean
    doc: Include tName in indexes (for non-split chain tables)
    inputBinding:
      position: 104
      prefix: -tIndex
  - id: no_bin
    type:
      - 'null'
      - boolean
    doc: 'Suppress bin field, default: bin field is added'
    inputBinding:
      position: 104
      prefix: -noBin
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: Don't sort by target (memory-intensive) -- input *must* be sorted by 
      target already if this option is used.
    inputBinding:
      position: 104
      prefix: -noSort
  - id: norm_score
    type:
      - 'null'
      - boolean
    doc: 'Add normalized score column to table, default: not added'
    inputBinding:
      position: 104
      prefix: -normScore
  - id: old_table
    type:
      - 'null'
      - boolean
    doc: 'Add to existing table, default: create new table'
    inputBinding:
      position: 104
      prefix: -oldTable
  - id: query_prefix
    type:
      - 'null'
      - string
    doc: Prepend "xxx" to query name
    inputBinding:
      position: 104
      prefix: -qPrefix
  - id: sql_table
    type:
      - 'null'
      - string
    doc: Create table from .sql file
    inputBinding:
      position: 104
      prefix: -sqlTable
  - id: test
    type:
      - 'null'
      - boolean
    doc: Suppress loading to database
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
stdout: ucsc-hgloadchain_hgLoadChain.out
