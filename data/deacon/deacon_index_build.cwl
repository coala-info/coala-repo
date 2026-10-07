cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deacon
  - index
  - build
label: deacon_index_build
doc: "Index minimizers contained within a fastx file\n\nTool homepage: https://github.com/bede/deacon"
inputs:
  - id: input
    type: File
    doc: Path to input fastx file (supports gz, zst and xz compression)
    inputBinding:
      position: 1
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: K-mer length used for indexing (k+w-1 must be <= 96 and odd)
    inputBinding:
      position: 101
      prefix: -k
  - id: window_size
    type:
      - 'null'
      - int
    doc: Minimizer window size used for indexing
    inputBinding:
      position: 101
      prefix: -w
  - id: output
    type: string
    doc: Path to output index file
    inputBinding:
      position: 101
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of execution threads (0 = auto)
    inputBinding:
      position: 101
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress sequence header output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: entropy_threshold
    type:
      - 'null'
      - float
    doc: Minimum scaled entropy threshold for k-mer filtering (0.0-1.0)
    inputBinding:
      position: 101
      prefix: --entropy-threshold
outputs:
  - id: index
    type: File
    doc: Minimizer index file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
