cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_threshold
label: tracs_threshold
doc: "Estimates transmission thresholds.\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs:
  - id: close_file
    type: File
    doc: "path to csv file with distances between isolates\n                     \
      \   mostly linked by recent transmission"
    inputBinding:
      position: 101
      prefix: --close
  - id: column
    type:
      - 'null'
      - int
    doc: index of column containing SNP distances (default=1)
    default: 1
    inputBinding:
      position: 101
      prefix: --column
  - id: distant_file
    type: File
    doc: "path to csv file with distances between isolates not\n                 \
      \       related by recent transmission"
    inputBinding:
      position: 101
      prefix: --distant
outputs:
  - id: output_file
    type: File
    doc: location of an output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
