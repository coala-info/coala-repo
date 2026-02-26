cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy sample-filter
label: dimspy_sample-filter
doc: "Apply sample filter to a peak matrix.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: input
    type: File
    doc: HDF5 file or tab-delimited file that contains a peak matrix.
    inputBinding:
      position: 101
      prefix: --input
  - id: labels
    type:
      - 'null'
      - File
    doc: Tab delimited file with at least two columns named 'filename' and 
      'classLabel'.
    inputBinding:
      position: 101
      prefix: --labels
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: Minimum percentage of samples a peak has to be present.
    inputBinding:
      position: 101
      prefix: --min-fraction
  - id: qc_label
    type:
      - 'null'
      - string
    doc: Class label for QCs
    inputBinding:
      position: 101
      prefix: --qc-label
  - id: rsd_threshold
    type:
      - 'null'
      - float
    doc: Peaks where the associated QC peaks are above this threshold will be 
      removed.
    inputBinding:
      position: 101
      prefix: --rsd-threshold
  - id: within
    type:
      - 'null'
      - boolean
    doc: Apply sample filter within each sample class.
    inputBinding:
      position: 101
      prefix: --within
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peak matrix object to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
