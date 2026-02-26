cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snipe
  - qc
label: snipe_qc
doc: "Perform quality control (QC) on multiple samples against a reference genome.\n\
  \nTool homepage: https://github.com/snipe-bio/snipe"
inputs:
  - id: amplicon
    type:
      - 'null'
      - File
    doc: Amplicon signature file (optional).
    inputBinding:
      position: 101
      prefix: --amplicon
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use for parallel processing.
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging and detailed logging.
    inputBinding:
      position: 101
      prefix: --debug
  - id: export_var
    type:
      - 'null'
      - boolean
    doc: Export signatures for sample hashes found in the variance signature.
    inputBinding:
      position: 101
      prefix: --export-var
  - id: metadata
    type:
      - 'null'
      - string
    doc: Additional metadata in the format `colname=value,colname=value,...`. 
      Applies to all samples.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: metadata_from_file
    type:
      - 'null'
      - File
    doc: File containing metadata information in TSV or CSV format. Each row 
      should have `sample_path,metadata_col,value`.
    inputBinding:
      position: 101
      prefix: --metadata-from-file
  - id: ref
    type: File
    doc: Reference genome signature file.
    inputBinding:
      position: 101
      prefix: --ref
  - id: roi
    type:
      - 'null'
      - boolean
    doc: Calculate ROI for 1x, 2x, 5x, and 9x coverage folds.
    inputBinding:
      position: 101
      prefix: --roi
  - id: sample
    type:
      - 'null'
      - type: array
        items: File
    doc: Sample signature file. Can be provided multiple times.
    inputBinding:
      position: 101
      prefix: --sample
  - id: samples_from_file
    type:
      - 'null'
      - File
    doc: File containing sample paths (one per line).
    inputBinding:
      position: 101
      prefix: --samples-from-file
  - id: var
    type:
      - 'null'
      - type: array
        items: File
    doc: Variance signature file path. Can be used multiple times.
    inputBinding:
      position: 101
      prefix: --var
  - id: ychr
    type:
      - 'null'
      - File
    doc: Y chromosome signature file (overrides the reference ychr).
    inputBinding:
      position: 101
      prefix: --ychr
outputs:
  - id: output
    type: File
    doc: Output TSV file for QC results.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
