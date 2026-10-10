cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, collinear]
label: mumemto_collinear
doc: "Computes collinear blocks of MUMs.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: mums
    type: File
    doc: "Path to the *.mums file from mumemto"
    inputBinding:
      position: 100
      prefix: --mums
  - id: fout
    type: string
    doc: Output file name; .mums is added when it has no .mums or .bumbl ending
    inputBinding:
      position: 100
      prefix: --fout
  - id: max_gap_len
    type:
      - 'null'
      - int
    doc: "Maximum break between collinear MUMs within a collinear block (default: 1kbp)"
    inputBinding:
      position: 100
      prefix: --max-gap-len
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 100
      prefix: --verbose
  - id: min_singleton_length
    type:
      - 'null'
      - int
    doc: "Minimum length of singleton blocks to include (default: no singletons)"
    inputBinding:
      position: 100
      prefix: --min-singleton-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: blocks
    type:
      type: array
      items: File
    doc: Collinear block files written by mumemto collinear
    outputBinding:
      glob: "$(inputs.fout)*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto_collinear.out
