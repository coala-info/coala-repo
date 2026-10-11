cwlVersion: v1.2
class: CommandLineTool
baseCommand: ococo
label: ococo
doc: "Online consensus caller: calls the consensus from an unsorted SAM/BAM stream.\n\nTool homepage: https://github.com/karel-brinda/ococo"
inputs:
  - id: input
    type: File
    doc: Input SAM/BAM file (- for standard input).
    inputBinding:
      position: 101
      prefix: -i
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: Initial FASTA reference (otherwise a sequence of N is used).
    inputBinding:
      position: 101
      prefix: -f
  - id: stats_in
    type:
      - 'null'
      - File
    doc: Input statistics.
    inputBinding:
      position: 101
      prefix: -s
  - id: fasta_cons
    type:
      - 'null'
      - string
    doc: FASTA file with consensus.
    inputBinding:
      position: 101
      prefix: -F
  - id: stats_out
    type:
      - 'null'
      - string
    doc: Output statistics.
    inputBinding:
      position: 101
      prefix: -S
  - id: vcf_cons
    type:
      - 'null'
      - string
    doc: VCF file with updates of consensus (- for standard output).
    inputBinding:
      position: 101
      prefix: -V
  - id: pileup
    type:
      - 'null'
      - string
    doc: Truncated pileup (- for standard output).
    inputBinding:
      position: 101
      prefix: -P
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (report every update of a counter).
    inputBinding:
      position: 101
      prefix: --verbose
  - id: counters
    type:
      - 'null'
      - string
    doc: "Counter configuration: ococo16 (3b/counter, 16b/position), ococo32 (7b/counter, 32b/position) or ococo64 (15b/counter, 64b/position)."
    inputBinding:
      position: 101
      prefix: -x
  - id: mode
    type:
      - 'null'
      - string
    doc: "Mode: real-time (updates reported immediately) or batch (updates reported after end of alignment stream)."
    inputBinding:
      position: 101
      prefix: -m
  - id: strategy
    type:
      - 'null'
      - string
    doc: "Strategy for updates: majority, stochastic or no-updates."
    inputBinding:
      position: 101
      prefix: -t
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Skip alignments with mapping quality smaller than INT.
    inputBinding:
      position: 101
      prefix: -q
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Skip bases with base quality smaller than INT.
    inputBinding:
      position: 101
      prefix: -Q
  - id: ref_weight
    type:
      - 'null'
      - int
    doc: Initial counter value for nucleotides from ref.
    inputBinding:
      position: 101
      prefix: -w
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage required for update.
    inputBinding:
      position: 101
      prefix: -c
  - id: maj_thres
    type:
      - 'null'
      - float
    doc: Majority threshold.
    inputBinding:
      position: 101
      prefix: -M
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (for example VCF or pileup when - is given)
  - id: consensus_fasta
    type:
      - 'null'
      - File
    doc: FASTA file with consensus
    outputBinding:
      glob: "$(inputs.fasta_cons && inputs.fasta_cons != '-' ? inputs.fasta_cons : 'no_fasta_cons_file_given')"
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Output statistics
    outputBinding:
      glob: "$(inputs.stats_out && inputs.stats_out != '-' ? inputs.stats_out : 'no_stats_out_file_given')"
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: VCF file with updates of consensus
    outputBinding:
      glob: "$(inputs.vcf_cons && inputs.vcf_cons != '-' ? inputs.vcf_cons : 'no_vcf_cons_file_given')"
  - id: pileup_file
    type:
      - 'null'
      - File
    doc: Truncated pileup
    outputBinding:
      glob: "$(inputs.pileup && inputs.pileup != '-' ? inputs.pileup : 'no_pileup_file_given')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ococo:0.1.2.7--h077b44d_10
stdout: ococo.out
