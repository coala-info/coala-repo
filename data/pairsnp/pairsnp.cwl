cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairsnp
label: pairsnp
doc: "Fast pairwise SNP distance matrices\n\nTool homepage: https://github.com/gtonkinhill/pairsnp"
inputs:
  - id: alignment_file
    type: File
    doc: Input alignment file (fasta or fasta.gz)
    inputBinding:
      position: 1
  - id: csv_output
    type:
      - 'null'
      - boolean
    doc: Output CSV instead of TSV
    inputBinding:
      position: 102
      prefix: -c
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: Distance threshold for sparse output. Only distances <= d will be returned.
    inputBinding:
      position: 102
      prefix: -d
  - id: index_inplace_of_header
    type:
      - 'null'
      - boolean
    doc: Output sequence index inplace of header (useful for downstream processing)
    inputBinding:
      position: 102
      prefix: -i
  - id: knn
    type:
      - 'null'
      - int
    doc: Will on return the k nearest neighbours for each sample in sparse output.
    inputBinding:
      position: 102
      prefix: -k
  - id: sparse_output
    type:
      - 'null'
      - boolean
    doc: Output in sparse matrix form (i,j,distance).
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairsnp:0.3.1--h077b44d_4
stdout: pairsnp.out
