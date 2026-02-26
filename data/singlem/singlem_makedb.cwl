cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - singlem
  - makedb
label: singlem_makedb
doc: "Create a searchable OTU sequence database from an OTU table\n\nTool homepage:
  https://github.com/wwood/singlem"
inputs:
  - id: archive_otu_table_list
    type:
      - 'null'
      - File
    doc: Make a db from the archive tables newline separated in this file
    inputBinding:
      position: 101
      prefix: --archive-otu-table-list
  - id: archive_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: Make a db from these archive tables
    inputBinding:
      position: 101
      prefix: --archive-otu-tables
  - id: db
    type: string
    doc: Name of database to create e.g. tundra.sdb
    inputBinding:
      position: 101
      prefix: --db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: gzip_archive_otu_table_list
    type:
      - 'null'
      - File
    doc: Make a db from the gzip'd archive tables newline separated in this file
    inputBinding:
      position: 101
      prefix: --gzip-archive-otu-table-list
  - id: num_annoy_nucleotide_trees
    type:
      - 'null'
      - int
    doc: make annoy nucleotide sequence indices with this ntrees
    default: 10
    inputBinding:
      position: 101
      prefix: --num-annoy-nucleotide-trees
  - id: num_annoy_protein_trees
    type:
      - 'null'
      - int
    doc: make annoy protein sequence indices with this ntrees
    default: 10
    inputBinding:
      position: 101
      prefix: --num-annoy-protein-trees
  - id: otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: Make a db from these OTU tables
    inputBinding:
      position: 101
      prefix: --otu-tables
  - id: otu_tables_list
    type:
      - 'null'
      - File
    doc: Make a db from the OTU table files newline separated in this file
    inputBinding:
      position: 101
      prefix: --otu-tables-list
  - id: pregenerated_otu_sqlite_db
    type:
      - 'null'
      - File
    doc: '[for internal usage] remake the indices using this input SQLite database'
    inputBinding:
      position: 101
      prefix: --pregenerated-otu-sqlite-db
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sequence_database_methods
    type:
      - 'null'
      - type: array
        items: string
    doc: Index sequences using these methods. Note that specifying "scann-naive"
      means "scann" databases will also be built
    default:
      - smafa-naive
    inputBinding:
      position: 101
      prefix: --sequence-database-methods
  - id: sequence_database_types
    type:
      - 'null'
      - type: array
        items: string
    doc: Index sequences using these types.
    default:
      - nucleotide
    inputBinding:
      position: 101
      prefix: --sequence-database-types
  - id: threads
    type:
      - 'null'
      - int
    doc: Use this many threads where possible
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: '[for internal usage] use this directory internally for working'
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
stdout: singlem_makedb.out
