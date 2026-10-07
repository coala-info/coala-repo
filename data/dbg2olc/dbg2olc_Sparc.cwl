cwlVersion: v1.2
class: CommandLineTool
baseCommand: Sparc
label: dbg2olc_Sparc
doc: "Sparc: sparsity-based consensus for a backbone sequence (DBG2OLC backbone polishing)
  from reads mapped with blasr -m 5.\n\nTool homepage: https://github.com/yechengxi/DBG2OLC"
inputs:
  - id: backbone_file
    type: File
    doc: backbone file.
    inputBinding:
      position: 101
      prefix: b
  - id: mapped_file
    type: File
    doc: the reads mapping file produced by blasr, using option -m 5.
    inputBinding:
      position: 101
      prefix: m
  - id: hq_prefix
    type:
      - 'null'
      - string
    doc: Shared prefix of the high quality read names.
    inputBinding:
      position: 101
      prefix: HQ_Prefix
  - id: boost
    type:
      - 'null'
      - int
    doc: 'boosting weight for the high quality reads. (range: [1,5])'
    inputBinding:
      position: 101
      prefix: boost
  - id: coverage_threshold
    type:
      - 'null'
      - int
    doc: 'coverage threshold. (range: [1,5])'
    inputBinding:
      position: 101
      prefix: c
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'k-mer size. (range: [1,5])'
    inputBinding:
      position: 101
      prefix: k
  - id: skip_size
    type:
      - 'null'
      - int
    doc: 'skip size, the larger the value, the more memory efficient the algorithm
      is. (range: [1,5])'
    inputBinding:
      position: 101
      prefix: g
  - id: threshold
    type:
      - 'null'
      - float
    doc: Consensus threshold (used as `t 0.2` by the bundled 
      split_and_run_sparc.sh)
    inputBinding:
      position: 101
      prefix: t
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output name prefix; the consensus is written to 
      <prefix>.consensus.fasta (default Consensus)
    default: Consensus
    inputBinding:
      position: 101
      prefix: o
outputs:
  - id: consensus_output
    type: File
    doc: Consensus sequence
    outputBinding:
      glob: $(inputs.output_prefix).consensus.fasta
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
