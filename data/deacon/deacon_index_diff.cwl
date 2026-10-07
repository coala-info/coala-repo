cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deacon
  - index
  - diff
label: deacon_index_diff
doc: "Subtract minimizers in one index from another (A - B)\n\nTool homepage: https://github.com/bede/deacon"
inputs:
  - id: first
    type: File
    doc: Path to first index file
    inputBinding:
      position: 1
  - id: second
    type: File
    doc: Path to second index file or FASTX file
    inputBinding:
      position: 2
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: K-mer length (required if second argument is FASTX file, 1-32)
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (required if second argument is FASTX file)
    inputBinding:
      position: 101
      prefix: --window-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of execution threads (0 = auto)
    inputBinding:
      position: 101
      prefix: --threads
  - id: output
    type: string
    doc: Path to output index file
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: index
    type: File
    doc: Minimizer index with the second set removed
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
