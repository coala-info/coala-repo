cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl find
label: gretl_find
doc: "Find features in the graph and return a BED file for further analysis\n\nTool
  homepage: https://github.com/moinsebi/gretl"
inputs:
  - id: features
    type: string
    doc: 'Input feature file (one feature per line). Example: 1 (node), 1+ (dirnode),
      1+2+ (edge)'
    inputBinding:
      position: 101
      prefix: --features
  - id: gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: length
    type: string
    doc: Length
    inputBinding:
      position: 101
      prefix: --length
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
