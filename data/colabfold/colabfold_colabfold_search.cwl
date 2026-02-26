cwlVersion: v1.2
class: CommandLineTool
baseCommand: colabfold_search
label: colabfold_colabfold_search
doc: "Search for queries in databases and store results.\n\nTool homepage: https://github.com/sokrypton/ColabFold"
inputs:
  - id: query
    type:
      type: array
      items: File
    doc: fasta files with the queries.
    inputBinding:
      position: 1
  - id: dbbase
    type: Directory
    doc: The path to the database and indices you downloaded and created with 
      setup_databases.sh
    inputBinding:
      position: 2
  - id: base
    type: Directory
    doc: Directory for the results (and intermediate files)
    inputBinding:
      position: 3
  - id: align_eval
    type:
      - 'null'
      - float
    doc: E-value threshold for alignment.
    inputBinding:
      position: 104
      prefix: --align-eval
  - id: db1
    type:
      - 'null'
      - string
    doc: UniRef database
    inputBinding:
      position: 104
      prefix: --db1
  - id: db2
    type:
      - 'null'
      - string
    doc: Templates database
    inputBinding:
      position: 104
      prefix: --db2
  - id: db3
    type:
      - 'null'
      - string
    doc: Environmental database
    inputBinding:
      position: 104
      prefix: --db3
  - id: db_load_mode
    type:
      - 'null'
      - string
    doc: Mode for loading the database.
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: diff
    type:
      - 'null'
      - float
    doc: Difference threshold.
    inputBinding:
      position: 104
      prefix: --diff
  - id: expand_eval
    type:
      - 'null'
      - float
    doc: E-value threshold for expanding alignments.
    inputBinding:
      position: 104
      prefix: --expand-eval
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Whether to filter results (0 or 1).
    inputBinding:
      position: 104
      prefix: --filter
  - id: max_accept
    type:
      - 'null'
      - int
    doc: Maximum number of accepted hits.
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: mmseqs
    type:
      - 'null'
      - File
    doc: Location of the mmseqs binary
    inputBinding:
      position: 104
      prefix: --mmseqs
  - id: pairing_strategy
    type:
      - 'null'
      - string
    doc: Strategy for pairing sequences.
    inputBinding:
      position: 104
      prefix: --pairing_strategy
  - id: qsc
    type:
      - 'null'
      - float
    doc: Query score threshold.
    inputBinding:
      position: 104
      prefix: --qsc
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: MMseqs2 sensitivity. Lowering this will result in a much faster search 
      but possibly sparser MSAs. By default, the k-mer threshold is directly set
      to the same one of the server, which corresponds to a sensitivity of ~8.
    inputBinding:
      position: 104
      prefix: --s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 104
      prefix: --threads
  - id: use_env
    type:
      - 'null'
      - boolean
    doc: Whether to use the environmental database (0 or 1).
    inputBinding:
      position: 104
      prefix: --use-env
  - id: use_templates
    type:
      - 'null'
      - boolean
    doc: Whether to use templates (0 or 1).
    inputBinding:
      position: 104
      prefix: --use-templates
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colabfold:1.5.5--pyh7cba7a3_2
stdout: colabfold_colabfold_search.out
