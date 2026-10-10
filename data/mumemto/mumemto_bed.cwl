cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, bed]
label: mumemto_bed
doc: "Convert MUMs file to BED file.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: mums_file
    type: File
    doc: Path to the MUMs file
    inputBinding:
      position: 1
  - id: lengths_file
    type:
      - 'null'
      - File
    doc: Path to the lengths file (optional)
    inputBinding:
      position: 100
      prefix: --lengths-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output with progress bars
    inputBinding:
      position: 100
      prefix: --verbose
  - id: min_singleton_length
    type:
      - 'null'
      - int
    doc: Minimum length of singleton blocks to include
    inputBinding:
      position: 100
      prefix: --min-singleton-length
  - id: seq_idx
    type:
      - 'null'
      - int
    doc: "Sequence to output BED coordinates for (default: first sequence)"
    inputBinding:
      position: 100
      prefix: --seq-idx
  - id: output
    type:
      - 'null'
      - string
    doc: "Path to the output file (default: standard output)"
    inputBinding:
      position: 100
      prefix: --output
outputs:
  - id: bed
    type: stdout
    doc: BED output (standard output)
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file written with --output
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto_bed.out
