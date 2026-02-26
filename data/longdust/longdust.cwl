cwlVersion: v1.2
class: CommandLineTool
baseCommand: longdust
label: longdust
doc: "Finds regions of high sequence complexity in a FASTA file.\n\nTool homepage:
  https://github.com/lh3/longdust"
inputs:
  - id: in_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: approximate_algorithm
    type:
      - 'null'
      - boolean
    doc: guaranteed O(Lw) algorithm but with more approximation
    inputBinding:
      position: 102
      prefix: -a
  - id: extension_xdrop_length
    type:
      - 'null'
      - int
    doc: extension X-drop length (0 to disable)
    default: 50
    inputBinding:
      position: 102
      prefix: -e
  - id: forward_strand_only
    type:
      - 'null'
      - boolean
    doc: forward strand only
    inputBinding:
      position: 102
      prefix: -f
  - id: genome_gc_content
    type:
      - 'null'
      - float
    doc: genome-wide GC content
    default: 0.5
    inputBinding:
      position: 102
      prefix: -g
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    default: 7
    inputBinding:
      position: 102
      prefix: -k
  - id: min_start_kmer_count
    type:
      - 'null'
      - int
    doc: min start k-mer count (2 or 3)
    default: 3
    inputBinding:
      position: 102
      prefix: -s
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: score threshold
    default: 0.6
    inputBinding:
      position: 102
      prefix: -t
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size
    default: 5000
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longdust:1.4--h577a1d6_0
stdout: longdust.out
