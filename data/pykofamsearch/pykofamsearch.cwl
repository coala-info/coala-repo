cwlVersion: v1.2
class: CommandLineTool
baseCommand: pykofamsearch
label: pykofamsearch
doc: "PyKOfamSearch\n\nTool homepage: https://github.com/jolespin/pykofamsearch"
inputs:
  - id: all_hits
    type:
      - 'null'
      - boolean
    doc: Return all hits and do not use curated threshold. Not recommended for 
      large queries.
    inputBinding:
      position: 101
      prefix: --all_hits
  - id: database_directory
    type: Directory
    doc: path/to/kofam_database_directory/ cannot be used with 
      -b/-serialized_database
    inputBinding:
      position: 101
      prefix: --database_directory
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value threshold
    default: 0.1
    inputBinding:
      position: 101
      prefix: --evalue
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --n_jobs
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: No header
    inputBinding:
      position: 101
      prefix: --no_header
  - id: proteins
    type: File
    doc: path/to/proteins.fasta. stdin does not stream and loads everything into
      memory.
    inputBinding:
      position: 101
      prefix: --proteins
  - id: serialized_database
    type:
      - 'null'
      - File
    doc: path/to/database.pkl cannot be used with -d/--database_directory
    inputBinding:
      position: 101
      prefix: --serialized_database
  - id: subset
    type:
      - 'null'
      - File
    doc: path/to/identifiers.list where HMM identifiers are on a separate line 
      used to subset the database. Only HMMs in the subset will be used.
    inputBinding:
      position: 101
      prefix: --subset
  - id: threshold_scale
    type:
      - 'null'
      - float
    doc: Multiplier for the curated thresholds. Higher values will make the 
      annotation more strict
    default: 1.0
    inputBinding:
      position: 101
      prefix: --threshold_scale
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Verbosity of missing KOfams
    default: 1
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output
    type: File
    doc: path/to/output.tsv
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
