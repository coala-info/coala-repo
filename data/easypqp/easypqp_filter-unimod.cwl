cwlVersion: v1.2
class: CommandLineTool
baseCommand: easypqp_filter-unimod
label: easypqp_filter-unimod
doc: "Filter unimodified peptides from a PQP file.\n\nTool homepage: https://github.com/grosenberger/easypqp"
inputs:
  - id: input_pqp
    type: File
    doc: Input PQP file.
    inputBinding:
      position: 1
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum peptide length to keep.
    default: 9999
    inputBinding:
      position: 102
      prefix: --max_length
  - id: min_intensity
    type:
      - 'null'
      - float
    doc: Minimum intensity to keep a peptide.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --min_intensity
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum peptide length to keep.
    default: 0
    inputBinding:
      position: 102
      prefix: --min_length
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum score to keep a peptide.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --min_score
  - id: unimod_ids
    type:
      - 'null'
      - type: array
        items: int
    doc: List of UNIMOD IDs to filter out (comma-separated).
    inputBinding:
      position: 102
      prefix: --unimod_ids
  - id: unimod_mods
    type:
      - 'null'
      - type: array
        items: string
    doc: List of UNIMOD modifications to filter out (comma-separated).
    inputBinding:
      position: 102
      prefix: --unimod_mods
outputs:
  - id: output_pqp
    type: File
    doc: Output PQP file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
