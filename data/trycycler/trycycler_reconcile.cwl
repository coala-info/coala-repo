cwlVersion: v1.2
class: CommandLineTool
baseCommand: trycycler reconcile
label: trycycler_reconcile
doc: "reconcile contig sequences\n\nTool homepage: https://github.com/rrwick/Trycycler"
inputs:
  - id: cluster_dir
    type: Directory
    doc: Cluster directory (should contain a 1_contigs subdirectory)
    inputBinding:
      position: 101
      prefix: --cluster_dir
  - id: linear
    type:
      - 'null'
      - boolean
    doc: 'The input contigs are not circular (default: assume the input contigs are
      circular)'
    inputBinding:
      position: 101
      prefix: --linear
  - id: max_add_seq
    type:
      - 'null'
      - int
    doc: Maximum allowed sequence length to be added in order to fix 
      circularisation
    inputBinding:
      position: 101
      prefix: --max_add_seq
  - id: max_add_seq_percent
    type:
      - 'null'
      - float
    doc: Maximum allowed percent relative sequence length to be added in order 
      to fix circularisation
    inputBinding:
      position: 101
      prefix: --max_add_seq_percent
  - id: max_length_diff
    type:
      - 'null'
      - float
    doc: Maximum allowed pairwise relative length difference
    inputBinding:
      position: 101
      prefix: --max_length_diff
  - id: max_mash_dist
    type:
      - 'null'
      - float
    doc: Maximum allowed pairwise Mash distance
    inputBinding:
      position: 101
      prefix: --max_mash_dist
  - id: max_trim_seq
    type:
      - 'null'
      - int
    doc: Maximum allowed sequence length to be trimmed in order to fix 
      circularisation
    inputBinding:
      position: 101
      prefix: --max_trim_seq
  - id: max_trim_seq_percent
    type:
      - 'null'
      - float
    doc: Maximum allowed percent relative sequence length to be trimmed in order
      to fix circularisation
    inputBinding:
      position: 101
      prefix: --max_trim_seq_percent
  - id: min_1kbp_identity
    type:
      - 'null'
      - float
    doc: Minimum allowed pairwise 1kbp window identity
    inputBinding:
      position: 101
      prefix: --min_1kbp_identity
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum allowed pairwise percent identity
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: reads
    type: File
    doc: Long reads (FASTQ format) used to generate the assemblies
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for alignment
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display extra output (for debugging)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
stdout: trycycler_reconcile.out
