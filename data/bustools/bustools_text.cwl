cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - text
label: bustools_text
doc: "Convert BUS files to text format\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: bus_files
    type:
      type: array
      items: File
    doc: BUS files to convert to text
    inputBinding:
      position: 1
  - id: flags
    type:
      - 'null'
      - boolean
    doc: Write the flag column
    inputBinding:
      position: 102
      prefix: --flags
  - id: pad
    type:
      - 'null'
      - boolean
    doc: Write the pad column
    inputBinding:
      position: 102
      prefix: --pad
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 102
      prefix: --pipe
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: Show hidden metadata in barcodes
    inputBinding:
      position: 102
      prefix: --showAll
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File for text output
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
