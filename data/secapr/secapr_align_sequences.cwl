cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr align_sequences
label: secapr_align_sequences
doc: "Create multiple sequence alignments from sequence collections\n\nTool homepage:
  https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: The alignment engine to use.
    default: muscle
    inputBinding:
      position: 101
      prefix: --aligner
  - id: conserve_alignment_percentage
    type:
      - 'null'
      - float
    doc: This setting will ensure to conserve the specified percentage of the 
      alignment when trimming (0-100).
    inputBinding:
      position: 101
      prefix: --conserve_alignment_percentage
  - id: cores
    type:
      - 'null'
      - int
    doc: Process alignments in parallel using --cores for alignment. This is the
      number of PHYSICAL CPUs.
    inputBinding:
      position: 101
      prefix: --cores
  - id: exclude_ambiguous
    type:
      - 'null'
      - boolean
    doc: Don't allow reads in alignments containing N-bases.
    inputBinding:
      position: 101
      prefix: --exclude_ambiguous
  - id: gap_extension_penalty
    type:
      - 'null'
      - float
    doc: Set gap extension penalty for aligner.
    inputBinding:
      position: 101
      prefix: --gap_extension_penalty
  - id: gap_opening_penalty
    type:
      - 'null'
      - float
    doc: Set gap opening penalty for aligner.
    inputBinding:
      position: 101
      prefix: --gap_opening_penalty
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of alignments to keep.
    inputBinding:
      position: 101
      prefix: --min_length
  - id: min_seqs_per_locus
    type:
      - 'null'
      - int
    doc: Minimum number of sequences required for building alignment.
    inputBinding:
      position: 101
      prefix: --min_seqs_per_locus
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Suppress trimming of alignments. By default secapr uses trimal to trim 
      gappy positions from alignments.
    inputBinding:
      position: 101
      prefix: --no_trim
  - id: seq_proportion
    type:
      - 'null'
      - float
    doc: The proportion of sequences required. All alignment columns with fewer 
      sequences will be deleted (0-1).
    inputBinding:
      position: 101
      prefix: --seq_proportion
  - id: sequences
    type: File
    doc: The fasta file containing individual sequences for several samples and 
      loci
    inputBinding:
      position: 101
      prefix: --sequences
  - id: trimal_setting
    type:
      - 'null'
      - string
    doc: Use one of trimal automated scenarios. These will overwrite all other 
      trimming flags (see below). See trimal tutorial for more info about 
      settings.
    inputBinding:
      position: 101
      prefix: --trimal_setting
  - id: window_size
    type:
      - 'null'
      - int
    doc: Sliding window size for trimming.
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: outdir
    type: Directory
    doc: The directory in which to store the resulting alignments.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
