cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrad
label: pyrad
doc: "pyRAD\n\nTool homepage: https://github.com/dereneaton/pyrad"
inputs:
  - id: dtest
    type:
      - 'null'
      - string
    doc: "input file for D-test of introgression,\n              can iterate over
      multiple samples"
    inputBinding:
      position: 101
      prefix: -d
  - id: new_dtest
    type:
      - 'null'
      - boolean
    doc: creates a new empty Dtest input file
    inputBinding:
      position: 101
      prefix: -D
  - id: new_params
    type:
      - 'null'
      - boolean
    doc: creates a new empty input params.txt file
    inputBinding:
      position: 101
      prefix: -n
  - id: params
    type:
      - 'null'
      - File
    doc: input file for within sample filtering and clustering
    inputBinding:
      position: 101
      prefix: -p
  - id: steps
    type:
      - 'null'
      - string
    doc: "perform step-wise parts of within analysis\n              1 = barcode sorting\n\
      \              2 = filter/edit raw sequences\n              3 = within-sample
      clustering\n              4 = estimate pi and e\n              5 = consensus
      calling\n              6 = cluster consensus\n              7 = align & create
      output files"
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrad:3.0.66--py27_0
stdout: pyrad.out
