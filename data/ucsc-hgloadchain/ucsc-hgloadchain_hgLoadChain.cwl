cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadChain
label: ucsc-hgloadchain_hgLoadChain
doc: "Load a generic Chain file into a database. The program reads the MySQL server login from ~/.hg.conf (give it as hg_conf); with -test no database is needed and the table data is left in chain.tab and link.tab.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: $(inputs.hg_conf)
inputs:
  - id: hg_conf
    type: ['null', File]
    doc: "hg.conf file with db.host, db.user and db.password of a writable UCSC MySQL server (staged as ~/.hg.conf); not needed with -test"
  - id: t_index
    type: ['null', boolean]
    doc: Include tName in indexes (for non-split chain tables)
    inputBinding:
      prefix: -tIndex
      position: 1
  - id: no_bin
    type: ['null', boolean]
    doc: "Suppress the bin field (default: the bin field is added)"
    inputBinding:
      prefix: -noBin
      position: 2
  - id: no_sort
    type: ['null', boolean]
    doc: Do not sort by target (memory-intensive); the input must already be sorted by target if this option is used
    inputBinding:
      prefix: -noSort
      position: 3
  - id: old_table
    type: ['null', boolean]
    doc: "Add to an existing table (default: create a new table)"
    inputBinding:
      prefix: -oldTable
      position: 4
  - id: sql_table
    type: ['null', File]
    doc: Create the table from this .sql file
    inputBinding:
      prefix: -sqlTable=
      separate: false
      position: 5
  - id: norm_score
    type: ['null', boolean]
    doc: "Add a normalized score column to the table (default: not added)"
    inputBinding:
      prefix: -normScore
      position: 6
  - id: q_prefix
    type: ['null', string]
    doc: Prepend this string to the query name
    inputBinding:
      prefix: -qPrefix=
      separate: false
      position: 7
  - id: test
    type: ['null', boolean]
    doc: Suppress loading to the database
    inputBinding:
      prefix: -test
      position: 8
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 10
  - id: chr_n_track
    type: string
    doc: Track (table) name, for example chrN_chainOther
    inputBinding:
      position: 11
  - id: chr_n_chain
    type: File
    doc: Chain file to load
    inputBinding:
      position: 12
outputs:
  - id: chain_tab
    type: ['null', File]
    doc: Chain table data left by -test
    outputBinding:
      glob: chain.tab
  - id: link_tab
    type: ['null', File]
    doc: Chain link table data left by -test
    outputBinding:
      glob: link.tab
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadchain:482--h0b57e2e_0
stdout: ucsc-hgloadchain_hgLoadChain.out
