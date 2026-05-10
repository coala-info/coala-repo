cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barbell
  - filter
label: barbell_filter
doc: "Filter annotation files based on pattern\n\nTool homepage: https://github.com/rickbeeloo/barbell"
inputs:
  - id: file
    type: File
    doc: File containing patterns to filter by
    inputBinding:
      position: 101
      prefix: --file
  - id: input
    type: File
    doc: Input annotation file
    inputBinding:
      position: 101
      prefix: --input
  - id: dropped_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `dropped_path`
    inputBinding:
      position: 102
      prefix: --dropped
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output filtered file path
    outputBinding:
      glob: $(inputs.output_path)
  - id: dropped
    type:
      - 'null'
      - File
    doc: Write dropped read annotation to this file
    outputBinding:
      glob: $(inputs.dropped_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
