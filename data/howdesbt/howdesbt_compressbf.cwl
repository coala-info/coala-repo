cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - compressbf
label: howdesbt_compressbf
doc: "copy bloom filters using a different compression format\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: filters
    type:
      type: array
      items: File
    doc: "bloom filter files (usually .bf) to copy with a different compression format"
    inputBinding:
      position: 101
  - id: out
    type:
      - 'null'
      - string
    doc: "filename template for resulting bloom filter files; must contain the substring {in}, which is replaced by the root of the input filename"
    inputBinding:
      position: 102
      prefix: "--out="
      separate: false
  - id: rrr
    type:
      - 'null'
      - boolean
    doc: "copy the filter(s) to rrr-compressed bit vector(s) (this is the default)"
    inputBinding:
      position: 103
      prefix: "--rrr"
  - id: roar
    type:
      - 'null'
      - boolean
    doc: "copy the filter(s) to roar-compressed bit vector(s)"
    inputBinding:
      position: 104
      prefix: "--roar"
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: "copy the filter(s) to uncompressed bit vector(s) (this may be very slow)"
    inputBinding:
      position: 105
      prefix: "--uncompressed"
  - id: noouttree
    type:
      - 'null'
      - boolean
    doc: "don't write the resulting topology file"
    inputBinding:
      position: 106
      prefix: "--noouttree"
outputs:
  - id: compressed_filters
    type:
      type: array
      items: File
    doc: "compressed bloom filter files"
    outputBinding:
      glob: "*.bf"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
