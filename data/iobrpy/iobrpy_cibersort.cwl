cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - cibersort
label: iobrpy_cibersort
doc: "CIBERSORT analysis tool\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: abs_method
    type:
      - 'null'
      - string
    doc: Absolute scoring method
    inputBinding:
      position: 101
      prefix: --abs_method
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: Absolute mode (True/False)
    inputBinding:
      position: 101
      prefix: --absolute
  - id: input_path
    type: File
    doc: Path to mixture file (CSV or TSV)
    inputBinding:
      position: 101
      prefix: --input
  - id: perm
    type:
      - 'null'
      - int
    doc: Number of permutations
    inputBinding:
      position: 101
      prefix: --perm
  - id: qn
    type:
      - 'null'
      - boolean
    doc: Quantile normalization (True/False)
    inputBinding:
      position: 101
      prefix: --QN
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_path
    type: File
    doc: Path to save CIBERSORT results (CSV or TSV)
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
