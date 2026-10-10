cwlVersion: v1.2
class: CommandLineTool
baseCommand: [filter_matrix_by_distance.py]
label: nasp_filter_matrix_by_distance
doc: "Return a reduced NASP matrix of SNPs that are distant from each other.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: matrix
    type: File
    doc: "Path to the starting SNP matrix."
    inputBinding:
      position: 1
      prefix: --matrix
  - id: reference
    type: File
    doc: "Path to the reference fasta file."
    inputBinding:
      position: 1
      prefix: --reference
  - id: prefix
    type: string
    doc: "Prefix for output files (matrix and fasta)."
    inputBinding:
      position: 1
      prefix: --prefix
  - id: distance
    type:
      - 'null'
      - int
    doc: "Minimum distance two SNPs can be from each other. Default: 5000."
    inputBinding:
      position: 1
      prefix: --distance
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: "Files written with the output prefix."
    outputBinding:
      glob: $(inputs.prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
