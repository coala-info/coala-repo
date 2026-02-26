cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - /usr/local/bin/transit
  - normalize
label: transit_normalize
doc: "Normalize wig files\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: input_wig
    type: File
    doc: Input wig file
    inputBinding:
      position: 1
  - id: input_combined_wig
    type: File
    doc: Input combined wig file
    inputBinding:
      position: 102
      prefix: -c
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: Normalization method
    default: TTR
    inputBinding:
      position: 102
      prefix: -n
outputs:
  - id: output_wig
    type: File
    doc: Output wig file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
