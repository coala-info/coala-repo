cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - dumpbv
label: howdesbt_dumpbv
doc: "dump the content of bit vectors to the console\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: bit_vectors
    type:
      type: array
      items: File
    doc: "bit vector files, either .bv, .rrr or .roar"
    inputBinding:
      position: 101
  - id: bits
    type:
      - 'null'
      - int
    doc: "limit of the number of bits to display from each bit vector (default is 100)"
    inputBinding:
      position: 102
      prefix: "--bits="
      separate: false
  - id: bit_interval
    type:
      - 'null'
      - string
    doc: "interval of bits to display from each bit vector, as <start>..<end> (exclusive of --bits)"
    inputBinding:
      position: 103
  - id: wrap
    type:
      - 'null'
      - int
    doc: "number of bit positions allowed on a line"
    inputBinding:
      position: 104
      prefix: "--wrap="
      separate: false
  - id: chunk
    type:
      - 'null'
      - int
    doc: "number of bit positions shown in each chunk (default is 10)"
    inputBinding:
      position: 105
      prefix: "--chunk="
      separate: false
  - id: as01
    type:
      - 'null'
      - boolean
    doc: "show each bit as a 0 or 1 (by default zeros are '-' and ones are '+')"
    inputBinding:
      position: 106
      prefix: "--as01"
  - id: complement
    type:
      - 'null'
      - boolean
    doc: "show the bitwise complement of each vector"
    inputBinding:
      position: 107
      prefix: "--complement"
  - id: show_density
    type:
      - 'null'
      - boolean
    doc: "show fraction of ones in the vector (instead of showing bits)"
    inputBinding:
      position: 108
      prefix: "--show:density"
  - id: show_integers
    type:
      - 'null'
      - boolean
    doc: "show bit positions as a list of integers"
    inputBinding:
      position: 109
      prefix: "--show:integers"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
stdout: howdesbt_dumpbv.out
