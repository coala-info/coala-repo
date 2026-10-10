cwlVersion: v1.2
class: CommandLineTool
baseCommand: [find_duplicates]
label: nasp_find_duplicates
doc: "Find duplicated regions in the reference by aligning it against itself with nucmer.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: nucmerpath
    type:
      - 'null'
      - string
    doc: "Path to the 'nucmer' executable."
    inputBinding:
      position: 1
      prefix: --nucmerpath
  - id: reference
    type: File
    doc: "Path to the reference fasta file."
    inputBinding:
      position: 1
      prefix: --reference
outputs:
  - id: duplicates
    type: File
    doc: "Duplicates file (binary 0/1 FASTA)."
    outputBinding:
      glob: duplicates.txt
  - id: delta
    type:
      - 'null'
      - File
    doc: "Delta file of the reference against itself."
    outputBinding:
      glob: "*.delta"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
