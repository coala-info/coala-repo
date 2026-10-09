cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - bfdistance
label: howdesbt_bfdistance
doc: "compute the bitwise distance between bloom filters\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: filters
    type:
      type: array
      items: File
    doc: "bloom filter files (usually .bf); only filters with uncompressed bit vectors are allowed"
    inputBinding:
      position: 101
  - id: focus
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: "--focus="
          separate: false
    doc: "bloom filter file (usually .bf); when given, distances are reported between the filters and these focus filters"
    inputBinding:
      position: 102
  - id: bit_interval
    type:
      - 'null'
      - string
    doc: "interval of bits to use from each filter, as <start>..<end>"
    inputBinding:
      position: 103
  - id: bits
    type:
      - 'null'
      - int
    doc: "number of bits to use from each filter; same as 0..<N>"
    inputBinding:
      position: 104
      prefix: "--bits="
      separate: false
  - id: show_hamming
    type:
      - 'null'
      - boolean
    doc: "show the distance as hamming distance (this is the default)"
    inputBinding:
      position: 105
      prefix: "--show:hamming"
  - id: show_intersect
    type:
      - 'null'
      - boolean
    doc: "show the 'distance' as the number of 1s in common"
    inputBinding:
      position: 106
      prefix: "--show:intersect"
  - id: show_union
    type:
      - 'null'
      - boolean
    doc: "show the 'distance' as the number of 1s in either"
    inputBinding:
      position: 107
      prefix: "--show:union"
  - id: show_theta
    type:
      - 'null'
      - boolean
    doc: "show the 'distance' from A to B as N/D, where D is the number of 1s in A and N is the number of 1s A and B have in common"
    inputBinding:
      position: 108
      prefix: "--show:theta"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
stdout: howdesbt_bfdistance.out
