cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - capture
label: bustools_capture
doc: "Capture records from a BUS file based on a list of transcripts, UMIs, barcodes,
  or flags.\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: bus_files
    type:
      type: array
      items: File
    doc: BUS files to process
    inputBinding:
      position: 1
  - id: barcode
    type:
      - 'null'
      - boolean
    doc: Capture list is a list of barcodes to capture
    inputBinding:
      position: 102
      prefix: --barcode
  - id: capture
    type:
      - 'null'
      - File
    doc: Capture list
    inputBinding:
      position: 102
      prefix: --capture
  - id: complement
    type:
      - 'null'
      - boolean
    doc: Take complement of captured set
    inputBinding:
      position: 102
      prefix: --complement
  - id: ecmap
    type:
      - 'null'
      - File
    doc: File for mapping equivalence classes to transcripts (for --transcripts)
    inputBinding:
      position: 102
      prefix: --ecmap
  - id: flags
    type:
      - 'null'
      - boolean
    doc: Capture list is a list of flags to capture
    inputBinding:
      position: 102
      prefix: --flags
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 102
      prefix: --pipe
  - id: transcripts
    type:
      - 'null'
      - boolean
    doc: Capture list is a list of transcripts to capture
    inputBinding:
      position: 102
      prefix: --transcripts
  - id: txnames
    type:
      - 'null'
      - File
    doc: File with names of transcripts (for --transcripts)
    inputBinding:
      position: 102
      prefix: --txnames
  - id: umis
    type:
      - 'null'
      - boolean
    doc: Capture list is a list of UMIs to capture
    inputBinding:
      position: 102
      prefix: --umis
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File for captured output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
