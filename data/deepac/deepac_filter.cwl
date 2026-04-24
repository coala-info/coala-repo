cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepac filter
label: deepac_filter
doc: "Filter predictions based on thresholds and classes.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: input
    type: File
    doc: Input file path [.fasta].
    inputBinding:
      position: 1
  - id: predictions
    type: File
    doc: Predictions in matching order [.npy].
    inputBinding:
      position: 2
  - id: confidence_threshold
    type:
      - 'null'
      - float
    doc: Confidence threshold
    inputBinding:
      position: 103
      prefix: --confidence-threshold
  - id: n_classes
    type:
      - 'null'
      - int
    doc: Format pathogenic potentials to given precision
    inputBinding:
      position: 103
      prefix: --n-classes
  - id: paired_fasta
    type:
      - 'null'
      - File
    doc: Second mate input file path [.fasta].
    inputBinding:
      position: 103
      prefix: --paired-fasta
  - id: paired_predictions
    type:
      - 'null'
      - File
    doc: Second mate predictions in matching order [.npy].
    inputBinding:
      position: 103
      prefix: --paired-predictions
  - id: positive_classes
    type:
      - 'null'
      - type: array
        items: int
    doc: Format pathogenic potentials to given precision
    inputBinding:
      position: 103
      prefix: --positive-classes
  - id: potentials
    type:
      - 'null'
      - boolean
    doc: Print pathogenic potential values in .fasta headers.
    inputBinding:
      position: 103
      prefix: --potentials
  - id: precision
    type:
      - 'null'
      - int
    doc: Format pathogenic potentials to given precision
    inputBinding:
      position: 103
      prefix: --precision
  - id: std
    type:
      - 'null'
      - float
    doc: Standard deviations of predictions if MC dropout used.
    inputBinding:
      position: 103
      prefix: --std
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for binary classification
    inputBinding:
      position: 103
      prefix: --threshold
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path for positive predictions [.fasta].
    outputBinding:
      glob: $(inputs.output)
  - id: neg_output
    type:
      - 'null'
      - File
    doc: Output file path for negative predictions [.fasta].
    outputBinding:
      glob: $(inputs.neg_output)
  - id: undef_output
    type:
      - 'null'
      - File
    doc: Output file path for predictions not passing the confidence threshold 
      [.fasta].
    outputBinding:
      glob: $(inputs.undef_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
