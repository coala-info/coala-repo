cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ete3
  - ncbiquery
label: ete3_ncbiquery
doc: "Query the NCBI taxonomy database: dump a pruned taxonomy tree, descendants or
  lineage information for taxids or species names (ETE tree toolkit command line).\n\
  \nTool homepage: http://etetoolkit.org/"
inputs:
  - id: search
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of taxid or species names
    inputBinding:
      position: 101
      prefix: --search
  - id: db
    type:
      - 'null'
      - string
    doc: NCBI sqlite3 db file.
    inputBinding:
      position: 101
      prefix: --db
  - id: taxdump_file
    type:
      - 'null'
      - File
    doc: Use local NCBI taxdump file instead of downloading from NCBI.
    inputBinding:
      position: 101
      prefix: --taxdump_file
  - id: create
    type:
      - 'null'
      - boolean
    doc: Create taxdump file and exit.
    inputBinding:
      position: 101
      prefix: --create
  - id: fuzzy
    type:
      - 'null'
      - float
    doc: 'EXPERIMENTAL: fuzzy (and SLOW) search for species names that could not be
      translated into taxids; minimum string similarity.'
    inputBinding:
      position: 101
      prefix: --fuzzy
  - id: tree
    type:
      - 'null'
      - boolean
    doc: dump a pruned version of the NCBI taxonomy tree containing target 
      species
    inputBinding:
      position: 101
      prefix: --tree
  - id: descendants
    type:
      - 'null'
      - boolean
    doc: dump the descendant taxa for each of the queries
    inputBinding:
      position: 101
      prefix: --descendants
  - id: info
    type:
      - 'null'
      - boolean
    doc: dump NCBI taxonomy information for each target species
    inputBinding:
      position: 101
      prefix: --info
  - id: collapse_subspecies
    type:
      - 'null'
      - boolean
    doc: collapse all nodes under the species rank
    inputBinding:
      position: 101
      prefix: --collapse_subspecies
  - id: rank_limit
    type:
      - 'null'
      - string
    doc: discard all nodes under the provided rank
    inputBinding:
      position: 101
      prefix: --rank_limit
  - id: full_lineage
    type:
      - 'null'
      - boolean
    doc: do not prune one-child nodes; keep the complete lineage from root to 
      tips
    inputBinding:
      position: 101
      prefix: --full_lineage
  - id: output
    type:
      - 'null'
      - string
    doc: Base output file name
    inputBinding:
      position: 101
      prefix: -o
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0=totally quite, 1=errors only, 2=warning+errors, 3=info+warnings+errors
      4=debug'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ete3:3.1.2
stdout: ete3_ncbiquery.out
