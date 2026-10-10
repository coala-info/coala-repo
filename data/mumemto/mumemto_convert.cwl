cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, convert]
label: mumemto_convert
doc: "Converts Mumemto mum and bumbl formats.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: mums
    type:
      - 'null'
      - File
    doc: "Path to the *.mums file from mumemto"
    inputBinding:
      position: 100
      prefix: --mums
  - id: bumbl
    type:
      - 'null'
      - File
    doc: "Path to the *.bumbl file from mumemto"
    inputBinding:
      position: 100
      prefix: --bumbl
  - id: length_upsize
    type:
      - 'null'
      - boolean
    doc: Convert bumbl with 16 bit length to 32 bit (v1.3.1 onwards)
    inputBinding:
      position: 100
      prefix: --length-upsize
  - id: fout
    type:
      - 'null'
      - string
    doc: Output file name
    inputBinding:
      position: 100
      prefix: --fout
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 100
      prefix: --verbose
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunk size for writing the output MUM file
    inputBinding:
      position: 100
      prefix: --chunk-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: converted
    type:
      type: array
      items: File
    doc: Converted file
    outputBinding:
      glob: "$(inputs.fout)*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto_convert.out
