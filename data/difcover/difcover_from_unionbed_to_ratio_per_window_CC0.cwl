cwlVersion: v1.2
class: CommandLineTool
baseCommand: difcover_from_unionbed_to_ratio_per_window_CC0
label: difcover_from_unionbed_to_ratio_per_window_CC0
doc: "Calculates the ratio of coverage per window between two samples from a unionbed
  file.\n\nTool homepage: https://github.com/timnat/DifCover"
inputs:
  - id: unionbed_file
    type: File
    doc: Expected *.unionbed file
    inputBinding:
      position: 1
  - id: maximum_depth_sample1
    type:
      - 'null'
      - int
    doc: maximum depth of coverage for sample1
    default: 1000000
    inputBinding:
      position: 102
      prefix: -A
  - id: maximum_depth_sample2
    type:
      - 'null'
      - int
    doc: maximum depth of coverage for sample2
    default: 1000000
    inputBinding:
      position: 102
      prefix: -B
  - id: minimum_depth_sample1
    type:
      - 'null'
      - int
    doc: minimum depth of coverage for sample1
    default: 0
    inputBinding:
      position: 102
      prefix: -a
  - id: minimum_depth_sample2
    type:
      - 'null'
      - int
    doc: minimum depth of coverage for sample2
    default: 0
    inputBinding:
      position: 102
      prefix: -b
  - id: minimum_window_size
    type:
      - 'null'
      - int
    doc: minimum size of window to output
    default: 0
    inputBinding:
      position: 102
      prefix: -l
  - id: target_valid_bases
    type:
      - 'null'
      - int
    doc: Target number of valid bases in the window
    default: 1000
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_from_unionbed_to_ratio_per_window_CC0.out
