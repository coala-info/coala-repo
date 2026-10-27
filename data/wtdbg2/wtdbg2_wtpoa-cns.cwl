cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtpoa-cns
label: wtdbg2_wtpoa-cns
doc: "Consensuser for wtdbg using PO-MSA: builds consensus contig sequences from the .ctg.lay layout of wtdbg2.\n\nTool homepage: https://github.com/ruanjue/wtdbg2"
inputs:
  - id: input_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: -i
    doc: Input file(s) *.ctg.lay from wtdbg
    inputBinding:
      position: 101
  - id: output_file_path
    type: string
    doc: Output file name
    inputBinding:
      position: 102
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default 4)
    inputBinding:
      position: 103
      prefix: -t
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite
    inputBinding:
      position: 103
      prefix: -f
  - id: expected_max_node_length
    type:
      - 'null'
      - int
    doc: Expected max length of node, or the overlap length of two adjacent units in layout file (default 1500 bp)
    inputBinding:
      position: 103
      prefix: -j
  - id: match_score
    type:
      - 'null'
      - int
    doc: Match score (default 2)
    inputBinding:
      position: 103
      prefix: -M
  - id: mismatch_score
    type:
      - 'null'
      - int
    doc: Mismatch score (default -5)
    inputBinding:
      position: 103
      prefix: -X
  - id: insertion_score
    type:
      - 'null'
      - int
    doc: Insertion score (default -2)
    inputBinding:
      position: 103
      prefix: -I
  - id: deletion_score
    type:
      - 'null'
      - int
    doc: Deletion score (default -4)
    inputBinding:
      position: 103
      prefix: -D
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: Bandwidth (default 96)
    inputBinding:
      position: 103
      prefix: -B
  - id: window_size_fast_align
    type:
      - 'null'
      - int
    doc: Window size in the middle of the first read for fast align remaining reads (default 200). If negative, fast align is disabled and abs(W) is the band align score cutoff
    inputBinding:
      position: 103
      prefix: -W
  - id: min_aligned_size_in_window
    type:
      - 'null'
      - int
    doc: Min size of aligned size in window (default W * 0.5)
    inputBinding:
      position: 103
      prefix: -w
  - id: abort_tri_poa_on_fast_align_fail
    type:
      - 'null'
      - boolean
    doc: Abort TriPOA when any read cannot be fast aligned, then try POA
    inputBinding:
      position: 103
      prefix: -A
  - id: realignment_bandwidth
    type:
      - 'null'
      - int
    doc: Realignment bandwidth, 0 disables (default 16)
    inputBinding:
      position: 103
      prefix: -R
  - id: min_bases_for_consensus
    type:
      - 'null'
      - int
    doc: Min count of bases to call a consensus base (default 3)
    inputBinding:
      position: 103
      prefix: -C
  - id: min_frequency_non_gap
    type:
      - 'null'
      - float
    doc: Min frequency of non-gap bases to call a consensus base (default 0.5)
    inputBinding:
      position: 103
      prefix: -F
  - id: max_reads_poa_msa
    type:
      - 'null'
      - int
    doc: Max number of reads in PO-MSA (default 20)
    inputBinding:
      position: 103
      prefix: -N
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Consensus sequences
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtdbg2:2.0--h470a237_0
