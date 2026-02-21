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
outputs:
  - id: output
    type: File
    doc: Output filtered file path
    outputBinding:
      glob: $(inputs.output)
  - id: dropped
    type:
      - 'null'
      - File
    doc: Write dropped read annotation to this file
    outputBinding:
      glob: $(inputs.dropped)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
