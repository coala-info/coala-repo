cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge_stats
label: strainge_stats
doc: "Obtain statistics about a given k-mer set.\n\nTool homepage: The package home
  page"
inputs:
  - id: kmerset
    type: string
    doc: The K-mer set to load
    inputBinding:
      position: 1
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Output the list of k-mers in this set with corresponding counts.
    inputBinding:
      position: 102
      prefix: --counts
  - id: entropy
    type:
      - 'null'
      - boolean
    doc: Calculate Shannon entropy in bases and write to output.
    inputBinding:
      position: 102
      prefix: --entropy
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: Write the k-mer frequency histogram to output.
    inputBinding:
      position: 102
      prefix: --histogram
  - id: output_kmer_size
    type:
      - 'null'
      - boolean
    doc: Output k-mer size.
    inputBinding:
      position: 102
      prefix: -k
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file, defaults to standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
