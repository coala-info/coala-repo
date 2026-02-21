cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - inspect
label: bustools_inspect
doc: "Inspects a sorted BUS file and provides statistics\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: sorted_bus_file
    type: File
    doc: Sorted BUS file to inspect
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
  - id: onlist
    type:
      - 'null'
      - File
    doc: File of on-list barcodes to correct to
    inputBinding:
      position: 102
      prefix: --onlist
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 102
      prefix: --pipe
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File for JSON output (optional)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
