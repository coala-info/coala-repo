cwlVersion: v1.2
class: CommandLineTool
baseCommand: smakcr
label: smakcr
doc: "Print counts of K-mers of a given size across one or more FASTA files\n\nTool
  homepage: https://github.com/julibeg/smakcr"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Input FASTA file(s)
    inputBinding:
      position: 1
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: Output canonical k-mers
    inputBinding:
      position: 102
      prefix: --canonical
  - id: kmer_size
    type: int
    doc: K-mer size
    default: 3
    inputBinding:
      position: 102
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: -t
  - id: zero_counts
    type:
      - 'null'
      - boolean
    doc: Also output k-mers with zero counts
    inputBinding:
      position: 102
      prefix: --zero-counts
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smakcr:0.1.0--h4349ce8_0
