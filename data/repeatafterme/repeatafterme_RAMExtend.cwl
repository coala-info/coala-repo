cwlVersion: v1.2
class: CommandLineTool
baseCommand: RAMExtend
label: repeatafterme_RAMExtend
doc: "Perform a multiple sequence alignment (MSA) extension given an existing core
  MSA and the flanking sequences. The core may be a set of word matches, a previously
  development MSA, or the the result of any process that defines a core set of sequence
  relationships. The only requirement is that the sequences are aligned to nearly
  the same point along one or both of the core edges. The extension process is a form
  of anchored alignment where the details of the core alignment are considered fixed.\n\
  \nTool homepage: https://github.com/Dfam-consortium/RepeatAfterMe"
inputs:
  - id: addflanking
    type:
      - 'null'
      - int
    doc: Include an additional <num> bp of sequence to each sequence when using 
      the -outfa option.
    inputBinding:
      position: 101
      prefix: -addflanking
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: The maximum number of unbalanced gaps allowed. Half the bandwidth of 
      the banded Smith-Waterman algorithm.
    inputBinding:
      position: 101
      prefix: -bandwidth
  - id: cap_penalty
    type:
      - 'null'
      - int
    doc: Cap on penalty for exiting alignment of a sequence
    inputBinding:
      position: 101
      prefix: -cappenalty
  - id: cons_fa_path
    type:
      - 'null'
      - string
    doc: Save the left/right consensus sequences to a FASTA file.
    inputBinding:
      position: 101
      prefix: -cons
  - id: extend_left_right_size
    type:
      - 'null'
      - int
    doc: Size of region to extend left or right
    inputBinding:
      position: 101
      prefix: -L
  - id: gap
    type:
      - 'null'
      - int
    doc: If '-matrix repeatscout' used, apply this penalty for a gap
    inputBinding:
      position: 101
      prefix: -gap
  - id: gap_extension
    type:
      - 'null'
      - int
    doc: Affine gap extension penalty to override per-matrix default
    inputBinding:
      position: 101
      prefix: -gapextn
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Affine gap open penalty to override per-matrix default
    inputBinding:
      position: 101
      prefix: -gapopen
  - id: match
    type:
      - 'null'
      - int
    doc: If '-matrix repeatscout' used, apply this reward for match
    inputBinding:
      position: 101
      prefix: -match
  - id: matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix, one of 14p43g, 18p43g, 20p43g, 25p43g (divergence tuned
      DNA matrices for a 43% GC background) or repeatscout (the original RepeatScout
      scoring system).
    inputBinding:
      position: 101
      prefix: -matrix
  - id: max_occurrences
    type:
      - 'null'
      - int
    doc: Cap on the number of sequences to align
    inputBinding:
      position: 101
      prefix: -maxoccurrences
  - id: min_improvement
    type:
      - 'null'
      - int
    doc: Amount that a the alignment score needs to improve each step to be 
      considered progress
    inputBinding:
      position: 101
      prefix: -minimprovement
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum required length for a sequence to be reported
    inputBinding:
      position: 101
      prefix: -minlength
  - id: mismatch
    type:
      - 'null'
      - int
    doc: If '-matrix repeatscout' used, apply this penalty for a mismatch
    inputBinding:
      position: 101
      prefix: -mismatch
  - id: ranges_tsv
    type: File
    doc: Input ranges TSV file
    inputBinding:
      position: 101
      prefix: -ranges
  - id: seq_2bit
    type: File
    doc: Input 2bit sequence file
    inputBinding:
      position: 101
      prefix: -twobit
  - id: stop_after
    type:
      - 'null'
      - int
    doc: Stop the alignment after this number of no-progress columns
    inputBinding:
      position: 101
      prefix: -stopafter
  - id: verbose
    type:
      - 'null'
      - int
    doc: How verbose do you want it to be? 1 gives -v, 4 gives -vvvv (super-verbose).
    inputBinding:
      position: 101
      valueFrom: $("-" + "v".repeat(self))
  - id: outfa_seq_fa_path
    type:
      - 'null'
      - string
    doc: '# Save all the final sequences ( original range + extension ) #   to a file.'
    inputBinding:
      position: 102
      prefix: -outfa
  - id: outmat_file_path
    type:
      - 'null'
      - string
    doc: '# Dump the dp matrix paths to a file for debugging.'
    inputBinding:
      position: 103
      prefix: -outmat
  - id: outtsv_final_tsv_path
    type:
      - 'null'
      - string
    doc: '# Save the final sequence ranges to a TSV file.'
    inputBinding:
      position: 104
      prefix: -outtsv
outputs:
  - id: cons_fa
    type:
      - 'null'
      - File
    doc: Left/right consensus sequences.
    outputBinding:
      glob: $(inputs.cons_fa_path)
  - id: outtsv_final_tsv
    type:
      - 'null'
      - File
    doc: Save the final sequence ranges to a TSV file.
    outputBinding:
      glob: $(inputs.outtsv_final_tsv_path)
  - id: outfa_seq_fa
    type:
      - 'null'
      - File
    doc: Save all the final sequences ( original range + extension ) to a file.
    outputBinding:
      glob: $(inputs.outfa_seq_fa_path)
  - id: outmat_file
    type:
      - 'null'
      - File
    doc: Dump the dp matrix paths to a file for debugging.
    outputBinding:
      glob: $(inputs.outmat_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatafterme:0.0.7--h7b50bb2_0
