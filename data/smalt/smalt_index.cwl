cwlVersion: v1.2
class: CommandLineTool
baseCommand: smalt_index
label: smalt_index
doc: "Index a reference genome for SMALT alignment.\n\nTool homepage: https://github.com/roquie/smalte"
inputs:
  - id: index_name
    type: string
    doc: Name for the index
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: Reference genome file (e.g., FASTA format)
    inputBinding:
      position: 2
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Length of the k-mer words indexed.
    inputBinding:
      position: 103
      prefix: -k
  - id: stride
    type:
      - 'null'
      - int
    doc: Sample every <stepsiz>-th k-mer word (stride).
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalt:v0.7.6-8-deb_cv1
stdout: smalt_index.out
