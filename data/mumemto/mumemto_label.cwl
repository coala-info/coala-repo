cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, label]
label: mumemto_label
doc: "Extract the MUM sequences.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: mumfile
    type: File
    doc: Bumbl file to process
    inputBinding:
      position: 100
      prefix: --mumfile
  - id: output
    type:
      - 'null'
      - string
    doc: Path to the output file
    inputBinding:
      position: 100
      prefix: --output
  - id: lengths
    type:
      - 'null'
      - File
    doc: Path to an alternate lengths file
    inputBinding:
      position: 100
      prefix: --lengths
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output
    inputBinding:
      position: 100
      prefix: --verbose
  - id: contig_names
    type:
      - 'null'
      - boolean
    doc: Print contig names (sequence IDs) instead of numerical indexes
    inputBinding:
      position: 100
      prefix: --contig-names
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: labelled
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto_label.out
