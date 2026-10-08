cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfapy-renumber
label: gfapy_gfapy-renumber
doc: "Renumber the segments of a GFA assembly graph. The largest segment is renamed 01, down to the smallest segment 99. The amount of zero-padding required is determined automatically.\n\nTool homepage: https://github.com/ggonnella/gfapy"
inputs:
  - id: gfa
    type: File
    doc: "input GFA file"
    inputBinding:
      position: 2
  - id: out
    type: string
    doc: "output GFA file"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: renumbered_gfa
    type: File
    doc: "Renumbered GFA file"
    outputBinding:
      glob: "$(inputs.out)"
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
stdout: gfapy_gfapy-renumber.out
