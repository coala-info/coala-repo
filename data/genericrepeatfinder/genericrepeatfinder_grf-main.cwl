cwlVersion: v1.2
class: CommandLineTool
baseCommand: grf-main
label: genericrepeatfinder_grf-main
doc: "This program performs genome-wide terminal inverted repeat (TIR), terminal direct
  repeat (TDR), and MITE candidate detection for input genome sequences.\n\nTool homepage:
  https://github.com/bioinfolabmu/GenericRepeatFinder"
inputs:
  - id: alignment_block_ratio
    type:
      - 'null'
      - float
    doc: For the best alignment in the current block, if the length of aligned 
      sequences <= block_ratio * block_size, the alignment procedure will stop 
      and the end position of the best alignment will be returned. Otherwise, a 
      new block will be created and the alignment will continue from the current
      end position; default = 0.8.
    inputBinding:
      position: 101
      prefix: --block_ratio
  - id: alignment_block_size
    type:
      - 'null'
      - int
    doc: Block size during alignment; default = 100.
    inputBinding:
      position: 101
      prefix: --block
  - id: analysis_choice
    type: int
    doc: 'Choice of analysis: 0: TIR detection; 1: MITE candidate detection; 2: TDR
      detection.'
    inputBinding:
      position: 101
      prefix: -c
  - id: indel_penalty
    type:
      - 'null'
      - int
    doc: Penalty score (positive number) for 1 indel; default = 2.
    inputBinding:
      position: 101
      prefix: --indel
  - id: input_genome
    type: File
    doc: Input genome sequence file in FASTA format.
    inputBinding:
      position: 101
      prefix: -i
  - id: match_score
    type:
      - 'null'
      - int
    doc: Award score (positive number) for 1 match; default = 1.
    inputBinding:
      position: 101
      prefix: --match
  - id: max_indel
    type:
      - 'null'
      - int
    doc: Maximum number of indels allowed in the terminal repeats; set -1 to be 
      unlimited; default = -1.
    inputBinding:
      position: 101
      prefix: --max_indel
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches allowed in the terminal repeats; set -1 to
      be unlimited; default = -1.
    inputBinding:
      position: 101
      prefix: --max_mismatch
  - id: max_seed_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between two seed regions; for TIRs/TDRs, default = 
      980; for MITEs, default = 780.
    inputBinding:
      position: 101
      prefix: --max_space
  - id: max_spacer_length
    type:
      - 'null'
      - int
    doc: Maximum spacer length.
    inputBinding:
      position: 101
      prefix: --max_spacer_len
  - id: max_spacer_ratio
    type:
      - 'null'
      - float
    doc: Maximum length ratio of spacer/total sequence; set -1 to be unlimited; 
      default = -1.
    inputBinding:
      position: 101
      prefix: -r
  - id: max_terminal_repeat_length
    type:
      - 'null'
      - int
    doc: Maximum TR length.
    inputBinding:
      position: 101
      prefix: --max_tr
  - id: max_tsd_length
    type:
      - 'null'
      - int
    doc: Maximum length of TSDs; default = 10.
    inputBinding:
      position: 101
      prefix: --max_tsd
  - id: max_unpaired_percentage
    type:
      - 'null'
      - int
    doc: Maximum percentage of unpaired nucleotides in the terminal repeats; set
      -1 to be unlimited; default = 10.
    inputBinding:
      position: 101
      prefix: -p
  - id: min_seed_distance
    type:
      - 'null'
      - int
    doc: Minimum distance between two seed regions; for TIRs/TDRs, default = 0; 
      for MITEs, default = 30.
    inputBinding:
      position: 101
      prefix: --min_space
  - id: min_spacer_length
    type:
      - 'null'
      - int
    doc: Minimum spacer length.
    inputBinding:
      position: 101
      prefix: --min_spacer_len
  - id: min_terminal_repeat_length
    type:
      - 'null'
      - int
    doc: Minimum length of the terminal repeats; must >= 5.
    inputBinding:
      position: 101
      prefix: --min_tr
  - id: min_tsd_length
    type:
      - 'null'
      - int
    doc: Minimum length of TSDs; default = 2.
    inputBinding:
      position: 101
      prefix: --min_tsd
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty score (positive number) for 1 mismatch; default = 1.
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'Format for outputs; 0: FASTA format; 1: only IDs; default = 0.'
    inputBinding:
      position: 101
      prefix: -f
  - id: seed_length
    type:
      - 'null'
      - int
    doc: Length of the seed region; default = 10; must >= 5 and <= '--min_tr'.
    inputBinding:
      position: 101
      prefix: -s
  - id: seed_mismatch
    type:
      - 'null'
      - int
    doc: Maximum mismatch number in the seed region; default = 1.
    inputBinding:
      position: 101
      prefix: --seed_mismatch
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used in this program; default = 1.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genericrepeatfinder:1.0.2--h9948957_1
