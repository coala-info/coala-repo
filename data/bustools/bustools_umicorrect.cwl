cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - umicorrect
label: bustools_umicorrect
doc: "Correct UMIs in sorted BUS files\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: sorted_bus_files
    type:
      type: array
      items: File
    doc: Sorted BUS files
    inputBinding:
      position: 1
  - id: ecmap
    type:
      - 'null'
      - File
    doc: File for mapping equivalence classes to transcripts
    inputBinding:
      position: 102
      prefix: --ecmap
  - id: genemap
    type:
      - 'null'
      - File
    doc: File for mapping transcripts to genes
    inputBinding:
      position: 102
      prefix: --genemap
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 102
      prefix: --pipe
  - id: txnames
    type:
      - 'null'
      - File
    doc: File with names of transcripts
    inputBinding:
      position: 102
      prefix: --txnames
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory gene matrix files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
