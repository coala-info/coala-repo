cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cvrep
label: phylobayes-mpi_cvrep
doc: "Make random learning and test data sets from an alignment for cross-validation (cvrep).\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs:
  - id: datafile
    type: File
    doc: "alignment file"
    inputBinding:
      position: 1
  - id: n1
    type: int
    doc: "number of sites in each learning set"
    inputBinding:
      position: 2
  - id: n2
    type: int
    doc: "number of sites in each test set"
    inputBinding:
      position: 3
  - id: nrep
    type: int
    doc: "number of replicates"
    inputBinding:
      position: 4
  - id: outfile
    type: string
    doc: "prefix of the output files (outfile<rep>_learn.ali, outfile<rep>_test.ali)"
    inputBinding:
      position: 5
outputs:
  - id: data_sets
    type:
      - 'null'
      - type: array
        items: File
    doc: "Learning and test data sets"
    outputBinding:
      glob:
        - "$(inputs.outfile)*_learn.ali"
        - "$(inputs.outfile)*_test.ali"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
