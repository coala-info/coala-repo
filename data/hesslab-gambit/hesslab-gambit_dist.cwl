cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambit
label: hesslab-gambit_dist
doc: "Calculate the GAMBIT distances between a set of query genomes and a set of reference genomes.\n\nTool homepage: https://github.com/hesslab-gambit/gambit"
arguments:
  - position: 2
    valueFrom: dist
inputs:
  - id: db
    type:
      - 'null'
      - Directory
    doc: Directory containing GAMBIT database files (the root level --db option).
    inputBinding:
      position: 1
      prefix: --db
  - id: k
    type:
      - 'null'
      - int
    doc: Number of nucleotides to recognize AFTER prefix.
    inputBinding:
      position: 101
      prefix: -k
  - id: prefix
    type:
      - 'null'
      - string
    doc: K-mer prefix.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: output_path
    type: string
    doc: Output file.
    inputBinding:
      position: 101
      prefix: -o
  - id: query_genomes
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -q
    doc: Query genome(s) (may be used multiple times).
    inputBinding:
      position: 101
  - id: query_list
    type:
      - 'null'
      - File
    doc: File containing paths to query genomes, one per line.
    inputBinding:
      position: 101
      prefix: --ql
  - id: query_dir
    type:
      - 'null'
      - Directory
    doc: Parent directory of files in --ql.
    inputBinding:
      position: 101
      prefix: --qdir
  - id: query_signatures
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
        inputBinding:
          prefix: -r
    doc: Reference genome (may be used multiple times).
    inputBinding:
      position: 101
  - id: reference_list
    type:
      - 'null'
      - File
    doc: File containing paths to reference genomes, one per line.
    inputBinding:
      position: 101
      prefix: --rl
  - id: reference_dir
    type:
      - 'null'
      - Directory
    doc: Parent directory of files in --rl.
    inputBinding:
      position: 101
      prefix: --rdir
  - id: reference_signatures
    type:
      - 'null'
      - File
    doc: Reference signature file.
    inputBinding:
      position: 101
      prefix: --rs
  - id: square
    type:
      - 'null'
      - boolean
    doc: Calculate square distance matrix using query signatures only.
    inputBinding:
      position: 101
      prefix: --square
  - id: use_db
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
    doc: Distance matrix (CSV)
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
stdout: hesslab-gambit_dist.out
