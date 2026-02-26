cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastkit validate
label: fastkit_validate
doc: "Validate FASTA files in preparation for tool execution.\n\nThese functions should
  not alter contents but only raise exceptions or return\nboolean values to communicate
  validity of data.\n\nTool homepage: https://github.com/neoformit/fastkit"
inputs:
  - id: filename
    type: File
    doc: A filename to parse and correct.
    inputBinding:
      position: 1
  - id: dna
    type:
      - 'null'
      - boolean
    doc: Validate as IUPAC DNA sequence
    inputBinding:
      position: 102
      prefix: --dna
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length of sequence permitted (per-sequence)
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of sequence permitted (per-sequence)
    inputBinding:
      position: 102
      prefix: --min-length
  - id: no_unknown
    type:
      - 'null'
      - boolean
    doc: Prohibit unknown IUPAC characters (X/N) - requires --dna or --protein
    inputBinding:
      position: 102
      prefix: --no-unknown
  - id: protein
    type:
      - 'null'
      - boolean
    doc: Validate as IUPAC protein sequence
    inputBinding:
      position: 102
      prefix: --protein
  - id: sequence_count
    type:
      - 'null'
      - int
    doc: Maximum number of sequences that are permitted
    inputBinding:
      position: 102
      prefix: --sequence-count
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastkit:1.0.2--pyhdfd78af_0
stdout: fastkit_validate.out
