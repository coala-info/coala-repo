cwlVersion: v1.2
class: CommandLineTool
baseCommand: mupbwt
label: mupbwt
doc: "mupbwt\n\nTool homepage: https://github.com/dlcgold/muPBWT"
inputs:
  - id: details
    type:
      - 'null'
      - boolean
    doc: print memory usage details
    inputBinding:
      position: 101
      prefix: -d
  - id: input_file
    type:
      - 'null'
      - File
    doc: vcf/bcf file for the panel (macs file with --macs)
    inputBinding:
      position: 101
      prefix: -i
  - id: load
    type:
      - 'null'
      - File
    doc: path to load serialization
    inputBinding:
      position: 101
      prefix: -l
  - id: macs
    type:
      - 'null'
      - boolean
    doc: use macs format for panel and queries
    inputBinding:
      position: 101
      prefix: -m
  - id: query
    type:
      - 'null'
      - File
    doc: path to the query file (vcf/bcf, or macs with --macs)
    inputBinding:
      position: 101
      prefix: -q
  - id: save
    type:
      - 'null'
      - string
    doc: path to save serialization
    inputBinding:
      position: 101
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: extra prints
    inputBinding:
      position: 101
      prefix: -v
  - id: output_path
    type:
      - 'null'
      - string
    doc: path to query output
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: path to query output
    outputBinding:
      glob: $(inputs.output_path)
  - id: index
    type:
      - 'null'
      - File
    doc: Serialized index written with --save
    outputBinding:
      glob: $(inputs.save)
  - id: stdout
    type: stdout
    doc: Standard output (details and verbose messages)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mupbwt:0.1.2--h6ab5fc9_2
stdout: mupbwt.out
