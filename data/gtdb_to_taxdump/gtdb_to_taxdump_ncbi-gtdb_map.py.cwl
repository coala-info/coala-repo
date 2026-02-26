cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-gtdb_map.py
label: gtdb_to_taxdump_ncbi-gtdb_map.py
doc: "Map between NCBI & GTDB taxonomies\n\nTool homepage: https://github.com/nick-youngblut/gtdb_to_taxdump"
inputs:
  - id: tax_queries
    type: File
    doc: List of taxa to query (1 per line)
    inputBinding:
      position: 1
  - id: gtdb_metadata
    type:
      type: array
      items: File
    doc: '>=1 gtdb-metadata file (or url)'
    inputBinding:
      position: 2
  - id: column
    type:
      - 'null'
      - int
    doc: Column containing the queries; assuming a tab-delim table
    default: 1
    inputBinding:
      position: 103
      prefix: --column
  - id: completeness
    type:
      - 'null'
      - float
    doc: Only include GTDB genomes w/ >=X CheckM completeness
    default: 50.0
    inputBinding:
      position: 103
      prefix: --completeness
  - id: contamination
    type:
      - 'null'
      - float
    doc: Only include GTDB genomes w/ <X CheckM contamination
    default: 5.0
    inputBinding:
      position: 103
      prefix: --contamination
  - id: fraction
    type:
      - 'null'
      - float
    doc: Homogeneity of LCA (fraction) in order to be used
    default: 0.9
    inputBinding:
      position: 103
      prefix: --fraction
  - id: header
    type:
      - 'null'
      - boolean
    doc: Header in table of queries
    default: false
    inputBinding:
      position: 103
      prefix: --header
  - id: max_tips
    type:
      - 'null'
      - int
    doc: Max no. of tips used for LCA determination. If more, subsampling w/out 
      replacement
    default: 100
    inputBinding:
      position: 103
      prefix: --max-tips
  - id: names_dmp
    type:
      - 'null'
      - File
    doc: NCBI names.dmp file. Only needed if providing NCBI taxids
    default: None
    inputBinding:
      position: 103
      prefix: --names-dmp
  - id: no_prefix
    type:
      - 'null'
      - boolean
    doc: Strip off any [dpcofgs]__ taxonomic prefixes?
    default: false
    inputBinding:
      position: 103
      prefix: --no-prefix
  - id: nodes_dmp
    type:
      - 'null'
      - File
    doc: NCBI nodes.dmp file. Only needed if providing NCBI taxids
    default: None
    inputBinding:
      position: 103
      prefix: --nodes-dmp
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output file directory
    default: ncbi-gtdb
    inputBinding:
      position: 103
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Add prefix to all queries such as "s__"
    default: ''
    inputBinding:
      position: 103
      prefix: --prefix
  - id: procs
    type:
      - 'null'
      - int
    doc: No. of parallel processes
    default: 1
    inputBinding:
      position: 103
      prefix: --procs
  - id: query_taxonomy
    type:
      - 'null'
      - string
    doc: Taxonomy of the query list
    default: ncbi_taxonomy
    inputBinding:
      position: 103
      prefix: --query-taxonomy
  - id: rename
    type:
      - 'null'
      - boolean
    doc: Write query file with queries renamed?
    default: false
    inputBinding:
      position: 103
      prefix: --rename
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    default: false
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
stdout: gtdb_to_taxdump_ncbi-gtdb_map.py.out
