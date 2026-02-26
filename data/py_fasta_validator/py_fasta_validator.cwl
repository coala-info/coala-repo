cwlVersion: v1.2
class: CommandLineTool
baseCommand: py_fasta_validator
label: py_fasta_validator
doc: "Validate FASTA files.\n\nTool homepage: https://github.com/linsalrob/py_fasta_validator"
inputs:
  - id: fasta_file
    type: File
    doc: Path to the FASTA file to validate.
    inputBinding:
      position: 1
  - id: allowed_chars
    type:
      - 'null'
      - string
    doc: A string of characters allowed in sequences. Any other character will 
      be flagged.
    inputBinding:
      position: 102
      prefix: --allowed-chars
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case differences in sequence data.
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum allowed sequence length. Sequences longer than this will be 
      flagged.
    inputBinding:
      position: 102
      prefix: --max-seq-len
  - id: min_seq_len
    type:
      - 'null'
      - int
    doc: Minimum allowed sequence length. Sequences shorter than this will be 
      flagged.
    inputBinding:
      position: 102
      prefix: --min-seq-len
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Enforce strict validation rules. By default, some common deviations are
      tolerated.
    inputBinding:
      position: 102
      prefix: --strict
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file for validation results. If not provided, 
      results are printed to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-sphinxcontrib.autoprogram:v0.1.2-1-deb_cv1
