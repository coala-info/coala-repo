cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dimspy
  - hdf5-pm-to-txt
label: dimspy_hdf5-pm-to-txt
doc: "Converts a HDF5 peak matrix to a text file.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: attribute_name
    type:
      - 'null'
      - string
    doc: Type of matrix to print.
    inputBinding:
      position: 101
      prefix: --attribute_name
  - id: class_label_rsd
    type:
      - 'null'
      - string
    doc: Class label to select samples for RSD calculatons (e.g. QC).
    inputBinding:
      position: 101
      prefix: --class-label-rsd
  - id: comprehensive
    type:
      - 'null'
      - boolean
    doc: Comprehensive version of the peak matrix
    inputBinding:
      position: 101
      prefix: --comprehensive
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Values on each line of the file are separated by this character.
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: input
    type: File
    doc: HDF5 file that contains a peak matrix object from one of the processing
      steps.
    inputBinding:
      position: 101
      prefix: --input
  - id: representation_samples
    type:
      - 'null'
      - string
    doc: Should the rows or columns represent the samples?
    inputBinding:
      position: 101
      prefix: --representation-samples
outputs:
  - id: output
    type: File
    doc: Directory (peaklists) or text file (peak matrix) to write to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
