cwlVersion: v1.2
class: CommandLineTool
baseCommand: states
label: mosaicatcher_states
doc: "Call Sister chromatid exchange events (SCEs).\n\nTool homepage: https://github.com/friendsofstrandseq/mosaicatcher/"
inputs:
  - id: counts_file
    type: File
    doc: Input count table file
    inputBinding:
      position: 1
  - id: ignore_low_support_regions
    type:
      - 'null'
      - int
    doc: Ignore segments with less reads than this
    inputBinding:
      position: 102
      prefix: --ignore-low-support-regions
  - id: ignore_small_regions
    type:
      - 'null'
      - int
    doc: Ignore segments of this size or smaller
    inputBinding:
      position: 102
      prefix: --ignore-small-regions
  - id: recurrent_fraction
    type:
      - 'null'
      - float
    doc: Fraction of cells with state change to be called recurrent
    inputBinding:
      position: 102
      prefix: --recurrent-fraction
  - id: recurrent_window_size
    type:
      - 'null'
      - int
    doc: Sliding window to determine recurrent state changes
    inputBinding:
      position: 102
      prefix: --recurrent-window-size
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file for counts
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
