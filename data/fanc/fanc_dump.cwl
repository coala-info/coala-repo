cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - dump
label: fanc_dump
doc: "Dump a Hic file to txt file(s).\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: hic
    type: File
    doc: "Hic file."
    inputBinding:
      position: 1
  - id: matrix
    type: string
    default: matrix.txt
    doc: "Output file for matrix entries."
    inputBinding:
      position: 2
  - id: regions
    type:
      - 'null'
      - string
    doc: "Output file for Hic regions. If not given, regions are written into the matrix file."
    inputBinding:
      position: 3
  - id: subset
    type:
      - 'null'
      - string
    doc: "Only output this matrix subset. Format: <chr>[:<start>-<end>][--<chr>[:<start><end>]], e.g.: \"chr1--chr1\" to extract only the chromosome 1 submatrix; \"chr2:3400000-4200000\" to extract contacts of this region on chromosome 2 to all other regions in the genome;"
    inputBinding:
      position: 20
      prefix: --subset
  - id: no_sparse
    type:
      - 'null'
      - boolean
    doc: "Store full, square matrix instead of sparse format."
    inputBinding:
      position: 20
      prefix: --no-sparse
  - id: only_intra
    type:
      - 'null'
      - boolean
    doc: "Only dump intra-chromosomal data. Dumps everything by default."
    inputBinding:
      position: 20
      prefix: --only-intra
  - id: observed_expected
    type:
      - 'null'
      - boolean
    doc: "O/E transform matrix values."
    inputBinding:
      position: 20
      prefix: --observed-expected
  - id: log2
    type:
      - 'null'
      - boolean
    doc: "Log2-transform matrix values. Useful for O/E matrices (-e option)"
    inputBinding:
      position: 20
      prefix: --log2
  - id: uncorrected
    type:
      - 'null'
      - boolean
    doc: "Output uncorrected (not normalised) matrix values)."
    inputBinding:
      position: 20
      prefix: --uncorrected
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: matrix_file
    type: File
    doc: "Matrix entries."
    outputBinding:
      glob: $(inputs.matrix)
  - id: regions_file
    type:
      - 'null'
      - File
    doc: "Hic regions."
    outputBinding:
      glob: $(inputs.regions)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
