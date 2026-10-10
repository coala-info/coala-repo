cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, extract]
label: mumemto_extract
doc: "Extract MUMs from a MUM and length file.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: mums
    type: File
    doc: Path to a mum file
    inputBinding:
      position: 100
      prefix: --mums
  - id: lengths
    type:
      - 'null'
      - File
    doc: Path to a length file (optional; uses the associated length file if not given)
    inputBinding:
      position: 100
      prefix: --lengths
  - id: output
    type: string
    doc: Output path
    inputBinding:
      position: 100
      prefix: --output
  - id: no_terminator
    type:
      - 'null'
      - boolean
    doc: "Do not add the terminator (#) to the end of each MUM sequence"
    inputBinding:
      position: 100
      prefix: --no-terminator
outputs:
  - id: extracted
    type: File
    doc: Extracted MUM sequences
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
