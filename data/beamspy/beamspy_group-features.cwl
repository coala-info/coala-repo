cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - beamspy
  - group-features
label: beamspy_group-features
doc: "Groups features based on correlation and retention time.\n\nTool homepage: https://github.com/computational-metabolomics/beamspy"
inputs:
  - id: coeff_threshold
    type: float
    doc: Threshold for correlation coefficient.
    inputBinding:
      position: 101
      prefix: --coeff-threshold
  - id: db
    type: File
    doc: Sqlite database to write results.
    inputBinding:
      position: 101
      prefix: --db
  - id: intensity_matrix
    type: File
    doc: Tab-delimited intensity matrix.
    inputBinding:
      position: 101
      prefix: --intensity-matrix
  - id: max_rt_diff
    type: float
    doc: Maximum difference in retention time between two peaks.
    inputBinding:
      position: 101
      prefix: --max-rt-diff
  - id: method
    type: string
    doc: Method to apply for grouping features.
    inputBinding:
      position: 101
      prefix: --method
  - id: ncpus
    type:
      - 'null'
      - int
    doc: Number of central processing units (CPUs).
    inputBinding:
      position: 101
      prefix: --ncpus
  - id: peaklist
    type: File
    doc: Tab-delimited peaklist.
    inputBinding:
      position: 101
      prefix: --peaklist
  - id: positive
    type:
      - 'null'
      - boolean
    doc: Use positive correlation only otherwise use both positive and negative 
      correlation.
    inputBinding:
      position: 101
      prefix: --positive
  - id: pvalue_threshold
    type: float
    doc: Threshold for p-value.
    inputBinding:
      position: 101
      prefix: --pvalue-threshold
outputs:
  - id: gml_file
    type: File
    doc: Write graph to GraphML format.
    outputBinding:
      glob: $(inputs.gml_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
