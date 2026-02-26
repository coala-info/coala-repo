cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_align_get_trimmed_alignments_from_untrimmed
label: phyluce_phyluce_align_get_trimmed_alignments_from_untrimmed
doc: "Use the PHYLUCE trimming algorithm to trim existing alignments in parallel\n\
  \nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: The directory containing alignments to be trimmed.
    inputBinding:
      position: 101
      prefix: --alignments
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
  - id: input_format
    type:
      - 'null'
      - string
    doc: The input alignment format.
    default: fasta
    inputBinding:
      position: 101
      prefix: --input-format
  - id: log_path
    type:
      - 'null'
      - Directory
    doc: The path to a directory to hold logs.
    default: None
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
      prefix: --max_divergence
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of alignments to keep.
    default: 100
    inputBinding:
      position: 101
      prefix: --min-length
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
