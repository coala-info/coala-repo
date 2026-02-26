cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gambit
  - dist
label: gambit_dist
doc: "Calculate the GAMBIT distances between a set of query geneomes and a set of
  reference genomes.\n\nTool homepage: https://github.com/jlumpe/gambit"
inputs:
  - id: calculate_square_matrix
    type:
      - 'null'
      - boolean
    doc: Calculate square distance matrix using query signatures only.
    inputBinding:
      position: 101
      prefix: --square
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use.
    inputBinding:
      position: 101
      prefix: -c
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Number of nucleotides to recognize AFTER prefix.
    inputBinding:
      position: 101
      prefix: -k
  - id: kmer_prefix
    type:
      - 'null'
      - string
    doc: K-mer prefix.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: no_progress_meter
    type:
      - 'null'
      - boolean
    doc: Don't show progress meter.
    inputBinding:
      position: 101
      prefix: --no-progress
  - id: progress_meter
    type:
      - 'null'
      - boolean
    doc: Show progress meter.
    inputBinding:
      position: 101
      prefix: --progress
  - id: query_genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Query genome(s) (may be used multiple times).
    inputBinding:
      position: 101
      prefix: -q
  - id: query_list_file
    type:
      - 'null'
      - File
    doc: File containing paths to query genomes, one per line.
    inputBinding:
      position: 101
      prefix: --ql
  - id: query_parent_directory
    type:
      - 'null'
      - Directory
    doc: Parent directory of paths in --ql.
    inputBinding:
      position: 101
      prefix: --qdir
  - id: query_signature_file
    type:
      - 'null'
      - File
    doc: Query signature file.
    inputBinding:
      position: 101
      prefix: --qs
  - id: reference_genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Reference genome (may be used multiple times).
    inputBinding:
      position: 101
      prefix: -r
  - id: reference_list_file
    type:
      - 'null'
      - File
    doc: File containing paths to reference genomes, one per line.
    inputBinding:
      position: 101
      prefix: --rl
  - id: reference_parent_directory
    type:
      - 'null'
      - Directory
    doc: Parent directory of paths in --rl.
    inputBinding:
      position: 101
      prefix: --rdir
  - id: reference_signature_file
    type:
      - 'null'
      - File
    doc: Reference signature file.
    inputBinding:
      position: 101
      prefix: --rs
  - id: use_reference_database
    type:
      - 'null'
      - boolean
    doc: Use reference signatures from database.
    inputBinding:
      position: 101
      prefix: --use-db
outputs:
  - id: output_file
    type: File
    doc: Output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
