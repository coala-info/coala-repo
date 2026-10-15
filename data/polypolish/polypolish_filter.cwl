cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polypolish
  - filter
label: polypolish_filter
doc: "filter paired-end alignments based on insert size\n\nTool homepage: https://github.com/rrwick/Polypolish"
inputs:
  - id: in1
    type: File
    doc: Input SAM file - first read in pairs
    inputBinding:
      position: 101
      prefix: --in1
  - id: in2
    type: File
    doc: Input SAM file - second read in pairs
    inputBinding:
      position: 101
      prefix: --in2
  - id: out1
    type: string
    doc: Output SAM file - first read in pairs
    inputBinding:
      position: 101
      prefix: --out1
  - id: out2
    type: string
    doc: Output SAM file - second read in pairs
    inputBinding:
      position: 101
      prefix: --out2
  - id: orientation
    type:
      - 'null'
      - string
    doc: 'Expected pair orientation [default: auto]'
    inputBinding:
      position: 101
      prefix: --orientation
  - id: low
    type:
      - 'null'
      - float
    doc: 'Low percentile threshold [default: 0.1]'
    inputBinding:
      position: 101
      prefix: --low
  - id: high
    type:
      - 'null'
      - float
    doc: 'High percentile threshold [default: 99.9]'
    inputBinding:
      position: 101
      prefix: --high
outputs:
  - id: filtered_sam1
    type: File
    doc: Filtered SAM file - first read in pairs
    outputBinding:
      glob: $(inputs.out1)
  - id: filtered_sam2
    type: File
    doc: Filtered SAM file - second read in pairs
    outputBinding:
      glob: $(inputs.out2)
  - id: log
    type: stderr
    doc: Polypolish report (standard error)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polypolish:0.6.1--h3ab6199_0
stderr: polypolish_filter.log
