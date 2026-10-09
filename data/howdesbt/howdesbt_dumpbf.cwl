cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - dumpbf
label: howdesbt_dumpbf
doc: "dump the content of a bloom filter to the console\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: filters
    type:
      type: array
      items: File
    doc: "bloom filter files (usually .bf)"
    inputBinding:
      position: 101
  - id: bits
    type:
      - 'null'
      - int
    doc: "limit of the number of bits to display from each filter (default is 100)"
    inputBinding:
      position: 102
      prefix: "--bits="
      separate: false
  - id: bit_interval
    type:
      - 'null'
      - string
    doc: "interval of bits to display from each filter, as <start>..<end> (exclusive of --bits)"
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
    doc: "show the bitwise complement of each filter"
    inputBinding:
      position: 107
      prefix: "--complement"
  - id: show_density
    type:
      - 'null'
      - boolean
    doc: "show fraction of ones in the filter (instead of showing bits)"
    inputBinding:
      position: 108
      prefix: "--show:density"
  - id: show_checksum
    type:
      - 'null'
      - boolean
    doc: "show a checksum of filter's bits (instead of showing bits)"
    inputBinding:
      position: 109
      prefix: "--show:checksum"
  - id: show_integers
    type:
      - 'null'
      - boolean
    doc: "show bit positions as a list of integers"
    inputBinding:
      position: 110
      prefix: "--show:integers"
  - id: show_header
    type:
      - 'null'
      - boolean
    doc: "show the filter's header info (instead of any bit data)"
    inputBinding:
      position: 111
      prefix: "--show:header"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
stdout: howdesbt_dumpbf.out
