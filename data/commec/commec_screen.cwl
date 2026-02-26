cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - commec
  - screen
label: commec_screen
doc: "Run Common Mechanism screening on an input FASTA.\n\nTool homepage: https://github.com/ibbis-screening/common-mechanism"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA file to screen
    inputBinding:
      position: 1
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Delete intermediate output files for this Screen run
    inputBinding:
      position: 102
      prefix: --cleanup
  - id: config_yaml
    type:
      - 'null'
      - File
    doc: Configuration for screen run in YAML format, including custom database 
      paths
    inputBinding:
      position: 102
      prefix: --config
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory containing reference databases (e.g. taxonomy, 
      protein, HMM)
    inputBinding:
      position: 102
      prefix: --databases
  - id: diamond_jobs
    type:
      - 'null'
      - int
    doc: 'Diamond-only: number of runs to do in parallel on split Diamond databases'
    inputBinding:
      position: 102
      prefix: --diamond-jobs
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: '(DEPRECATED: legacy commands for --fast-mode, please use --skip-tx to skip
      the taxonomy step instead.)'
    inputBinding:
      position: 102
      prefix: --fast-mode
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite any pre-existing output for this Screen run (cannot be used 
      with --resume)
    inputBinding:
      position: 102
      prefix: --force
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files. Can be a string (interpreted as output 
      basename) or a directory (files will be output there, names will be 
      determined from input FASTA)
    inputBinding:
      position: 102
      prefix: --output
  - id: protein_search_tool
    type:
      - 'null'
      - string
    doc: Tool for protein homology search to identify regulated pathogens
    inputBinding:
      position: 102
      prefix: --protein-search-tool
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Re-use any pre-existing output for this Screen run (cannot be used with
      --force)
    inputBinding:
      position: 102
      prefix: --resume
  - id: skip_nt
    type:
      - 'null'
      - boolean
    doc: Skip nucleotide search (regulated pathogens will only be identified 
      based on biorisk database and protein hits)
    inputBinding:
      position: 102
      prefix: --skip-nt
  - id: skip_nt_shorthand
    type:
      - 'null'
      - boolean
    doc: '(DEPRECATED: shorthand for --skip-nt, use --skip-nt instead.)'
    inputBinding:
      position: 102
      prefix: -n
  - id: skip_tx
    type:
      - 'null'
      - boolean
    doc: Skip taxonomy homology search (only toxins and other proteins included 
      in the biorisk database will be flagged)
    inputBinding:
      position: 102
      prefix: --skip-tx
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use. Passed to search tools.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output verbose (i.e. DEBUG-level) logs
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
stdout: commec_screen.out
