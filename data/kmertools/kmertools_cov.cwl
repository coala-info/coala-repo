cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmertools_cov
label: kmertools_cov
doc: "Generates coverage histogram based on the reads\n\nTool homepage: https://github.com/anuradhawick/kmertools"
inputs:
  - id: alt_input
    type:
      - 'null'
      - File
    doc: Input file path, for k-mer counting
    inputBinding:
      position: 101
      prefix: --alt-input
  - id: bin_count
    type:
      - 'null'
      - int
    doc: Number of bins for the coverage histogram
    inputBinding:
      position: 101
      prefix: --bin-count
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size for the coverage histogram
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Disable normalisation and output raw counts
    inputBinding:
      position: 101
      prefix: --counts
  - id: input_file
    type: File
    doc: Input file path
    inputBinding:
      position: 101
      prefix: --input
  - id: k_size
    type:
      - 'null'
      - int
    doc: K size for the coverage histogram
    inputBinding:
      position: 101
      prefix: --k-size
  - id: memory
    type:
      - 'null'
      - int
    doc: Max memory in GB
    inputBinding:
      position: 101
      prefix: --memory
  - id: preset
    type:
      - 'null'
      - string
    doc: Output type to write
    inputBinding:
      position: 101
      prefix: --preset
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread count for computations 0=auto
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory path
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
