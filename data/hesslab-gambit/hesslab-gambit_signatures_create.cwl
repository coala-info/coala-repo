cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambit
label: hesslab-gambit_signatures_create
doc: "Create k-mer signatures from genome sequences.\n\nTool homepage: https://github.com/hesslab-gambit/gambit"
arguments:
  - position: 2
    valueFrom: signatures
  - position: 3
    valueFrom: create
inputs:
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome sequence files (FASTA).
    inputBinding:
      position: 200
  - id: db
    type:
      - 'null'
      - Directory
    doc: Directory containing GAMBIT database files (the root level --db option; needed with db_params).
    inputBinding:
      position: 1
      prefix: --db
  - id: listfile
    type:
      - 'null'
      - File
    doc: File containing names/paths of genome files.
    inputBinding:
      position: 101
      prefix: -l
  - id: ldir
    type:
      - 'null'
      - Directory
    doc: Parent directory of paths in LISTFILE.
    inputBinding:
      position: 101
      prefix: --ldir
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
    doc: File path to write to.
    inputBinding:
      position: 101
      prefix: --output
  - id: meta_json
    type:
      - 'null'
      - File
    doc: JSON file containing metadata to attach.
    inputBinding:
      position: 101
      prefix: --meta-json
  - id: ids
    type:
      - 'null'
      - File
    doc: File containing genome IDs (one per line).
    inputBinding:
      position: 101
      prefix: --ids
  - id: db_params
    type:
      - 'null'
      - boolean
    doc: Use k/prefix from reference database.
    inputBinding:
      position: 101
      prefix: --db-params
outputs:
  - id: output_file
    type: File
    doc: Signature file
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
stdout: hesslab-gambit_signatures_create.out
