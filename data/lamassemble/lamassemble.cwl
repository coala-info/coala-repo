cwlVersion: v1.2
class: CommandLineTool
baseCommand: lamassemble
label: lamassemble
doc: "Merge DNA sequences into a consensus sequence.\n\nTool homepage: https://gitlab.com/mcfrith/lamassemble"
inputs:
  - id: last_train_out
    type: File
    doc: Input LAST alignment output file
    inputBinding:
      position: 1
  - id: sequences_fx
    type: File
    doc: Input DNA sequences file
    inputBinding:
      position: 2
  - id: consensus_name
    type:
      - 'null'
      - string
    doc: name of the consensus sequence
    inputBinding:
      position: 103
      prefix: --name
  - id: consensus_only
    type:
      - 'null'
      - boolean
    doc: just make a consensus, of already-aligned sequences
    inputBinding:
      position: 103
      prefix: --consensus
  - id: diagonal_max
    type:
      - 'null'
      - int
    doc: max change in alignment diagonal between pairwise alignments
    inputBinding:
      position: 103
      prefix: --diagonal-max
  - id: error_probability
    type:
      - 'null'
      - float
    doc: use pairwise restrictions with error probability <= P
    inputBinding:
      position: 103
      prefix: --prob
  - id: gap_max
    type:
      - 'null'
      - int
    doc: use alignment columns with <= G% gaps
    inputBinding:
      position: 103
      prefix: --gap-max
  - id: include_gaps_past_ends
    type:
      - 'null'
      - boolean
    doc: including gaps past the ends of the sequences
    inputBinding:
      position: 103
      prefix: --end
  - id: initial_matches_ratio
    type:
      - 'null'
      - string
    doc: use ~1 per this many initial matches
    inputBinding:
      position: 103
      prefix: -u
  - id: last_threads
    type:
      - 'null'
      - int
    doc: number of parallel threads
    inputBinding:
      position: 103
      prefix: -P
  - id: mafft_args
    type:
      - 'null'
      - string
    doc: additional arguments for MAFFT
    inputBinding:
      position: 103
      prefix: --mafft
  - id: max_gap_length
    type:
      - 'null'
      - int
    doc: max gap length
    inputBinding:
      position: 103
      prefix: -z
  - id: max_initial_matches
    type:
      - 'null'
      - int
    doc: max initial matches per query position
    inputBinding:
      position: 103
      prefix: -m
  - id: out_base
    type:
      - 'null'
      - string
    doc: just write MAFFT input files, named BASE.xxx
    inputBinding:
      position: 103
      prefix: --out
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'output format: fasta/fa or fastq/fq'
    inputBinding:
      position: 103
      prefix: --format
  - id: print_alignment
    type:
      - 'null'
      - boolean
    doc: print an alignment, not a consensus
    inputBinding:
      position: 103
      prefix: --alignment
  - id: seq_min
    type:
      - 'null'
      - int
    doc: omit consensus flanks with < S sequences
    inputBinding:
      position: 103
      prefix: --seq-min
  - id: use_all_sequence
    type:
      - 'null'
      - boolean
    doc: use all of each sequence, not just aligning part
    inputBinding:
      position: 103
      prefix: --all
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress messages
    inputBinding:
      position: 103
      prefix: --verbose
  - id: window_min_positions
    type:
      - 'null'
      - int
    doc: use minimum positions in length-W windows
    inputBinding:
      position: 103
      prefix: -W
outputs:
  - id: output_consensus_fa
    type: File
    doc: Output consensus FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lamassemble:1.7.2--pyh7cba7a3_0
