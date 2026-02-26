cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ac-diamond
  - view
label: ac-diamond_view
doc: "View AC-DIAMOND alignment archive (DAA) formatted file\n\nTool homepage: https://github.com/Maihj/AC-DIAMOND"
inputs:
  - id: daa
    type:
      - 'null'
      - File
    doc: AC-DIAMOND alignment archive (DAA) file
    inputBinding:
      position: 101
      prefix: --daa
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: forwardonly
    type:
      - 'null'
      - boolean
    doc: only show alignments of forward strand
    inputBinding:
      position: 101
      prefix: --forwardonly
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: outfmt
    type:
      - 'null'
      - string
    doc: output format (tab/sam)
    default: tab
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: threads
    type:
      - 'null'
      - int
    doc: number of cpu threads
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: enable verbose out
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
