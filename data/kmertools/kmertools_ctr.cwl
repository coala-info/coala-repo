cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmertools_ctr
label: kmertools_ctr
doc: "Count k-mers\n\nTool homepage: https://github.com/anuradhawick/kmertools"
inputs:
  - id: acgt
    type:
      - 'null'
      - boolean
    doc: "Output ACGT instead of numeric values\n          \n          This requires
      a larger space for the final result\n          compared to the compact numeric
      representation"
    inputBinding:
      position: 101
      prefix: --acgt
  - id: input
    type: File
    doc: Input file path
    inputBinding:
      position: 101
      prefix: --input
  - id: k_size
    type: int
    doc: k size for counting
    inputBinding:
      position: 101
      prefix: --k-size
  - id: memory
    type:
      - 'null'
      - int
    doc: Max memory in GB
    default: 6
    inputBinding:
      position: 101
      prefix: --memory
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread count for computations 0=auto
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: Output directory path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
