cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmertools
  - comp
  - cgr
label: kmertools_comp_cgr
doc: "Generates Chaos Game Representations\n\nTool homepage: https://github.com/anuradhawick/kmertools"
inputs:
  - id: input
    type: File
    doc: Input file path
    inputBinding:
      position: 101
      prefix: --input
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Disable normalisation and output raw counts (only with k-mer mode)
    inputBinding:
      position: 101
      prefix: --counts
  - id: k_size
    type:
      - 'null'
      - int
    doc: Set k-mer size or default to full sequence CGR
    inputBinding:
      position: 101
      prefix: --k-size
  - id: vec_size
    type:
      - 'null'
      - int
    doc: Set vector size (output will be a square matrix with N=vecsize)
    inputBinding:
      position: 101
      prefix: --vec-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread count for computations 0=auto
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: Output vectors path
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output vectors file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
