cwlVersion: v1.2
class: CommandLineTool
baseCommand: tedna
label: tedna
doc: "Tedna is a tool for detecting transposable elements in genomes.\n\nTool homepage:
  https://github.com/mzytnicki/tedna"
inputs:
  - id: big_graph
    type:
      - 'null'
      - int
    doc: Maximum graph size
    default: 100000
    inputBinding:
      position: 101
      prefix: --big-graph
  - id: bubble_size
    type:
      - 'null'
      - int
    doc: Size of the bubbles
    default: 1000
    inputBinding:
      position: 101
      prefix: --bubble-size
  - id: bytes_per_thread
    type:
      - 'null'
      - int
    doc: Number of bytes read per thread
    default: 10000000
    inputBinding:
      position: 101
      prefix: --bytes-per-thread
  - id: check
    type:
      - 'null'
      - string
    doc: Check if a sequence is assembled
    inputBinding:
      position: 101
      prefix: --check
  - id: duplicate_id
    type:
      - 'null'
      - float
    doc: Maximum id. to remove duplicate
    inputBinding:
      position: 101
      prefix: --duplicate-id
  - id: erosion
    type:
      - 'null'
      - int
    doc: Erosion strength
    default: 100
    inputBinding:
      position: 101
      prefix: --erosion
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: Input file is in FASTA format
    inputBinding:
      position: 101
      prefix: --fasta-input
  - id: file1
    type: File
    doc: First FASTQ file.
    inputBinding:
      position: 101
      prefix: --file1
  - id: file2
    type:
      - 'null'
      - File
    doc: Second FASTQ file.
    inputBinding:
      position: 101
      prefix: --file2
  - id: frequency_dif
    type:
      - 'null'
      - float
    doc: Maximum k-mer frequency difference
    default: 2.5
    inputBinding:
      position: 101
      prefix: --frequency-dif
  - id: indel_pen
    type:
      - 'null'
      - int
    doc: Indel penalty
    default: 30
    inputBinding:
      position: 101
      prefix: --indel-pen
  - id: insert
    type:
      - 'null'
      - int
    doc: Insert size.
    inputBinding:
      position: 101
      prefix: --insert
  - id: kmer
    type: int
    doc: K-mer size.
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_ltr
    type:
      - 'null'
      - int
    doc: Maximum LTR size
    default: 5000
    inputBinding:
      position: 101
      prefix: --max-ltr
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: Maximum overlap to merge TEs
    default: 500
    inputBinding:
      position: 101
      prefix: --max-overlap
  - id: max_paths
    type:
      - 'null'
      - int
    doc: 'Maximum # paths, 0: never stop.'
    default: 100
    inputBinding:
      position: 101
      prefix: --max-paths
  - id: max_pen
    type:
      - 'null'
      - int
    doc: Maximum penalty
    default: 200
    inputBinding:
      position: 101
      prefix: --max-pen
  - id: max_reads
    type:
      - 'null'
      - int
    doc: 'Maximum number of reads read, 0: read all.'
    default: 0
    inputBinding:
      position: 101
      prefix: --max-reads
  - id: max_scaffold
    type:
      - 'null'
      - int
    doc: Maximum number of evidences/scaff.
    default: 10000
    inputBinding:
      position: 101
      prefix: --max-scaffold
  - id: max_te_size
    type:
      - 'null'
      - int
    doc: Maximum TE size
    default: 30000
    inputBinding:
      position: 101
      prefix: --max-te-size
  - id: merge_max_nb
    type:
      - 'null'
      - int
    doc: 'Maximum number of repeats, 0: do not use.'
    default: 10000
    inputBinding:
      position: 101
      prefix: --merge-max-nb
  - id: merge_max_nodes
    type:
      - 'null'
      - int
    doc: 'Maximum number of neighbor/node, 0: do not use.'
    default: 10
    inputBinding:
      position: 101
      prefix: --merge-max-nodes
  - id: min_frequency
    type:
      - 'null'
      - int
    doc: Minimum k-mer frequency
    default: 3
    inputBinding:
      position: 101
      prefix: --min-frequency
  - id: min_id
    type:
      - 'null'
      - int
    doc: Minimum identity
    default: 80
    inputBinding:
      position: 101
      prefix: --min-id
  - id: min_ltr
    type:
      - 'null'
      - int
    doc: Minimum LTR size
    default: 50
    inputBinding:
      position: 101
      prefix: --min-ltr
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap to merge TEs
    default: 20
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: min_scaffold
    type:
      - 'null'
      - int
    doc: Minimum number of evidences/scaff.
    default: 100
    inputBinding:
      position: 101
      prefix: --min-scaffold
  - id: min_te_size
    type:
      - 'null'
      - int
    doc: Minimum TE size
    default: 500
    inputBinding:
      position: 101
      prefix: --min-te-size
  - id: mismatch_pen
    type:
      - 'null'
      - int
    doc: Mismatch penalty
    default: 10
    inputBinding:
      position: 101
      prefix: --mismatch-pen
  - id: processors
    type:
      - 'null'
      - int
    doc: Number of processors
    default: 2
    inputBinding:
      position: 101
      prefix: --processors
  - id: repeat_frequency
    type:
      - 'null'
      - int
    doc: Minimum number of repetitions
    default: 2
    inputBinding:
      position: 101
      prefix: --repeat-frequency
  - id: scaffold_max_nb
    type:
      - 'null'
      - int
    doc: 'Maximum number of neighbor/node, 0: do not use.'
    default: 5
    inputBinding:
      position: 101
      prefix: --scaffold-max-nb
  - id: short_kmer
    type:
      - 'null'
      - int
    doc: Small k-mer size
    default: 15
    inputBinding:
      position: 101
      prefix: --short-kmer
  - id: size_pen
    type:
      - 'null'
      - int
    doc: Size penalty
    default: 1
    inputBinding:
      position: 101
      prefix: --size-pen
  - id: small_graph
    type:
      - 'null'
      - int
    doc: Minimum graph size
    default: 300
    inputBinding:
      position: 101
      prefix: --small-graph
  - id: small_graph_count
    type:
      - 'null'
      - int
    doc: 'Stop after N small graphs, 0: never stop.'
    default: 10000
    inputBinding:
      position: 101
      prefix: --small-graph-count
  - id: threshold
    type:
      - 'null'
      - float
    doc: K-mer frequency threshold
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output
    type: File
    doc: Output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tedna:1.3.1--h503566f_0
