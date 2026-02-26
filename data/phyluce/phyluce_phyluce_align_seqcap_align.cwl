cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_phyluce_align_seqcap_align
label: phyluce_phyluce_align_seqcap_align
doc: "Align and possibly trim records in a monolithic UCE FASTA file with MAFFT or
  MUSCLE\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: The alignment engine to use.
    default: mafft
    inputBinding:
      position: 101
      prefix: --aligner
  - id: ambiguous
    type:
      - 'null'
      - boolean
    doc: Allow reads in alignments containing N-bases.
    default: false
    inputBinding:
      position: 101
      prefix: --ambiguous
  - id: cores
    type:
      - 'null'
      - int
    doc: Process alignments in parallel using --cores for alignment. This is the
      number of PHYSICAL CPUs.
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: fasta
    type: File
    doc: The file containing FASTA reads associated with targted loci from 
      get_fastas_from_match_counts.py
    inputBinding:
      position: 101
      prefix: --fasta
  - id: incomplete_matrix
    type:
      - 'null'
      - boolean
    doc: Allow alignments that do not contain all --taxa.
    default: false
    inputBinding:
      position: 101
      prefix: --incomplete-matrix
  - id: log_path
    type:
      - 'null'
      - Directory
    doc: The path to a directory to hold logs.
    inputBinding:
      position: 101
      prefix: --log-path
  - id: max_divergence
    type:
      - 'null'
      - float
    doc: The max proportion of sequence divergence allowed between any row of 
      the alignment and the alignment consensus.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --max-divergence
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of alignments to keep.
    default: 100
    inputBinding:
      position: 101
      prefix: --min-length
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Align, but DO NOT trim alignments.
    default: false
    inputBinding:
      position: 101
      prefix: --no-trim
  - id: output_format
    type:
      - 'null'
      - string
    doc: The output alignment format.
    default: nexus
    inputBinding:
      position: 101
      prefix: --output-format
  - id: proportion
    type:
      - 'null'
      - float
    doc: The proportion of taxa required to have sequence at alignment ends.
    default: 0.65
    inputBinding:
      position: 101
      prefix: --proportion
  - id: taxa
    type: int
    doc: Number of taxa expected in each alignment.
    inputBinding:
      position: 101
      prefix: --taxa
  - id: threshold
    type:
      - 'null'
      - float
    doc: The proportion of residues required across the window in proportion of 
      taxa.
    default: 0.65
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The logging level to use.
    default: INFO
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: window
    type:
      - 'null'
      - int
    doc: Sliding window size for trimming.
    default: 20
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type: Directory
    doc: The directory in which to store the resulting alignments.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
