cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-alignment
  - pairwise-knn
label: rdp-alignment_pairwise-knn
doc: "Compute the k nearest neighbors of each query sequence by pairwise alignment (PairwiseKNN).

Tool homepage: https://github.com/rdpstaff/Alignment"
inputs:
  - id: query_file
    type: File
    doc: "Query sequence file"
    inputBinding:
      position: 6
  - id: db_file
    type: File
    doc: "Database (reference) sequence file"
    inputBinding:
      position: 7
  - id: k
    type:
      - 'null'
      - int
    doc: "K-nearest neighbors to return (default 1)"
    inputBinding:
      position: 1
      prefix: -k
  - id: mode
    type:
      - 'null'
      - string
    doc: "Alignment mode {global, glocal, local, overlap, overlap_trimmed} (default glocal)"
    inputBinding:
      position: 2
      prefix: --mode
  - id: prefilter
    type:
      - 'null'
      - int
    doc: "The top p closest targets from the kmer prefilter step. Set p=0 to disable the prefilter step (default 10)"
    inputBinding:
      position: 3
      prefix: --prefilter
  - id: word_size
    type:
      - 'null'
      - int
    doc: "The word size used to find closest targets during prefilter (default 4 for protein, 8 for nucleotide)"
    inputBinding:
      position: 4
      prefix: --word-size
  - id: out_path
    type:
      - 'null'
      - string
    doc: "Redirect output to this file instead of stdout"
    inputBinding:
      position: 5
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out
    type:
      - 'null'
      - File
    doc: "Alignment hits of the nearest neighbors"
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
stdout: rdp-alignment_pairwise-knn.out
