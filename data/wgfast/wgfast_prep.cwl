cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgfast_prep
label: wgfast_prep
doc: "Prepare the reference files for wgfast: builds a RAxML tree (.tree) and the
  RAxML parameters file (.PARAMS) from a NASP SNP matrix.\n\nTool homepage: https://github.com/FofanovLab/wgfast"
inputs:
  - id: snp_matrix
    type: File
    doc: path to NASP snp_matrix
    inputBinding:
      position: 1
      prefix: --snp_matrix
  - id: model
    type:
      - 'null'
      - string
    doc: model for RAxML, defaults to ASC_GTRGAMMA, can also be GTRGAMMA
    inputBinding:
      position: 1
      prefix: --model
  - id: processors
    type:
      - 'null'
      - int
    doc: number of processors to use with GTRGAMMA, defaults to 4
    inputBinding:
      position: 1
      prefix: --processors
outputs:
  - id: tree
    type:
      - 'null'
      - File
    doc: RAxML maximum likelihood tree
    outputBinding:
      glob: '*.tree'
  - id: params
    type:
      - 'null'
      - File
    doc: RAxML parameters file
    outputBinding:
      glob: '*.PARAMS'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgfast:1.0.4--py_0
stdout: wgfast_prep.out
