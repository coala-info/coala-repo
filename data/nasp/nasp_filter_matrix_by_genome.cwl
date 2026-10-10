cwlVersion: v1.2
class: CommandLineTool
baseCommand: [filter_matrix_by_genome.py]
label: nasp_filter_matrix_by_genome
doc: "Keep or remove genomes (columns) of a NASP matrix.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: in_matrix
    type: File
    doc: "Path to the NASP matrix."
    inputBinding:
      position: 1
      prefix: --in_matrix
  - id: out_prefix
    type: string
    doc: "Prefix for output files."
    inputBinding:
      position: 1
      prefix: --out_prefix
  - id: genomes
    type: File
    doc: "Path to a newline delimited genomes file."
    inputBinding:
      position: 1
      prefix: --genomes
  - id: actions
    type:
      - 'null'
      - string
    doc: "Action to perform (keep, remove), default keep."
    inputBinding:
      position: 1
      prefix: --actions
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: "Files written with the output prefix."
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
