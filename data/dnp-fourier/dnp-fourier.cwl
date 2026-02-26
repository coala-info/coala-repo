cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-fourier
label: dnp-fourier
doc: "Fourier transform and smoothing of input sequence\n\nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs:
  - id: input_sequence
    type: File
    doc: input sequence
    inputBinding:
      position: 101
      prefix: -f
  - id: normalization_type
    type: int
    doc: type of normalisation
    inputBinding:
      position: 101
      prefix: -n
  - id: output_table_type
    type: int
    doc: type of output table
    inputBinding:
      position: 101
      prefix: -t
  - id: window_length
    type: int
    doc: length of window of smoothing
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: output_table
    type: File
    doc: output table
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-fourier:1.0--h503566f_6
