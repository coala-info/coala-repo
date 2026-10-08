cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gambit
label: gambit_signatures_create
doc: "Create k-mer signatures from genome sequences.\n\nTool homepage: https://github.com/jlumpe/gambit"
inputs:
  - id: db
    type:
      - 'null'
      - Directory
    doc: Directory containing GAMBIT database files (global option, given before the subcommand).
    inputBinding:
      position: 1
      prefix: --db
  - id: genomes
    type:
      type: array
      items: File
    doc: Genome sequences to process
    inputBinding:
      position: 4
  - id: listfile
    type:
      - 'null'
      - File
    doc: File containing paths to genome files, one per line.
    inputBinding:
      position: 102
      prefix: -l
  - id: ldir
    type:
      - 'null'
      - Directory
    doc: Parent directory of paths in LISTFILE.
    inputBinding:
      position: 102
      prefix: --ldir
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Number of nucleotides to recognize AFTER prefix.
    inputBinding:
      position: 102
      prefix: -k
  - id: prefix
    type:
      - 'null'
      - string
    doc: K-mer prefix.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: output_path
    type: string
    doc: File path to write to.
    inputBinding:
      position: 102
      prefix: --output
  - id: meta_json
    type:
      - 'null'
      - File
    doc: JSON file containing metadata to attach.
    inputBinding:
      position: 102
      prefix: --meta-json
  - id: ids
    type:
      - 'null'
      - File
    doc: File containing genome IDs (one per line).
    inputBinding:
      position: 102
      prefix: --ids
  - id: db_params
    type:
      - 'null'
      - boolean
    doc: Use k/prefix from reference database.
    inputBinding:
      position: 102
      prefix: --db-params
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress meter.
    inputBinding:
      position: 102
      prefix: --progress
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Don't show progress meter.
    inputBinding:
      position: 102
      prefix: --no-progress
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use.
    inputBinding:
      position: 102
      prefix: --cores
arguments:
  - position: 2
    valueFrom: signatures
  - position: 3
    valueFrom: create
outputs:
  - id: output
    type: File
    doc: Signature file (.gs) written by the tool.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
