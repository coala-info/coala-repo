cwlVersion: v1.2
class: CommandLineTool
baseCommand: Mikado compare
label: mikado_compare
doc: "Compare predictions to a reference annotation.\n\nTool homepage: https://github.com/lucventurini/mikado"
inputs:
  - id: distance
    type:
      - 'null'
      - float
    doc: Maximum distance for considering two features as matching
    inputBinding:
      position: 101
      prefix: --distance
  - id: exclude_redundant_matches
    type:
      - 'null'
      - boolean
    doc: Exclude redundant matches
    inputBinding:
      position: 101
      prefix: --exclude-redundant-matches
  - id: exclude_unannotated
    type:
      - 'null'
      - boolean
    doc: Exclude unannotated features
    inputBinding:
      position: 101
      prefix: --exclude-unannotated
  - id: fuzzy_match
    type:
      - 'null'
      - File
    doc: Fuzzy matching file
    inputBinding:
      position: 101
      prefix: --fuzzy-match
  - id: index
    type:
      - 'null'
      - boolean
    doc: Compare prediction to indexed reference (e.g., from a database)
    inputBinding:
      position: 101
      prefix: --index
  - id: internal
    type:
      - 'null'
      - boolean
    doc: Compare prediction to internal reference (e.g., from a previous run)
    inputBinding:
      position: 101
      prefix: --internal
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Lenient matching
    inputBinding:
      position: 101
      prefix: --lenient
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: --log
  - id: no_feature_type
    type:
      - 'null'
      - boolean
    doc: Do not consider feature type in comparisons
    inputBinding:
      position: 101
      prefix: --no-feature-type
  - id: no_shm
    type:
      - 'null'
      - boolean
    doc: Do not use shared memory for comparisons
    inputBinding:
      position: 101
      prefix: --no-shm
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize scores
    inputBinding:
      position: 101
      prefix: --normalize
  - id: percent_complete
    type:
      - 'null'
      - boolean
    doc: Calculate percent complete instead of overlap
    inputBinding:
      position: 101
      prefix: --percent-complete
  - id: prediction
    type:
      - 'null'
      - File
    doc: Prediction file (GTF/GFF3)
    inputBinding:
      position: 101
      prefix: --prediction
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes to use
    inputBinding:
      position: 101
      prefix: --processes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reference
    type: File
    doc: Reference annotation file (GTF/GFF3)
    inputBinding:
      position: 101
      prefix: --reference
  - id: self
    type:
      - 'null'
      - boolean
    doc: Compare prediction to itself (useful for internal comparisons)
    inputBinding:
      position: 101
      prefix: --self
  - id: shm
    type:
      - 'null'
      - boolean
    doc: Use shared memory for comparisons (default)
    inputBinding:
      position: 101
      prefix: --shm
  - id: use_prediction_attributes
    type:
      - 'null'
      - boolean
    doc: Use attributes from prediction file
    inputBinding:
      position: 101
      prefix: --use-prediction-attributes
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file for comparison results
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
