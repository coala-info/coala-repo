cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmfinder
label: cmfinder
doc: "learning motif covariance model for unaligned sequences\n\nTool homepage: https://sourceforge.net/projects/weinberg-cmfinder/"
inputs:
  - id: seqfile_in
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: candidate_file
    type:
      - 'null'
      - File
    doc: the candidate file
    inputBinding:
      position: 102
      prefix: -c
  - id: cmzasha_filter
    type:
      - 'null'
      - boolean
    doc: apply cmzasha filter
    inputBinding:
      position: 102
      prefix: --cmzasha
  - id: fragmentary
    type:
      - 'null'
      - boolean
    doc: account for fragmentary input sequences
    inputBinding:
      position: 102
      prefix: --fragmentary
  - id: gap_threshold
    type:
      - 'null'
      - float
    doc: the gap threshold to determine the conserved column
    inputBinding:
      position: 102
      prefix: --g
  - id: hmm_filter
    type:
      - 'null'
      - boolean
    doc: apply HMM filter
    inputBinding:
      position: 102
      prefix: --hmm
  - id: initial_align_file
    type:
      - 'null'
      - File
    doc: the initial motif alignment
    inputBinding:
      position: 102
      prefix: -a
  - id: initial_cm_file
    type:
      - 'null'
      - File
    doc: the initial covariance model
    inputBinding:
      position: 102
      prefix: -i
  - id: input_format
    type:
      - 'null'
      - string
    doc: specify that input alignment is in format <s>
    inputBinding:
      position: 102
      prefix: --informat
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update instead of scanning for new candidates at each iteration
    inputBinding:
      position: 102
      prefix: --update
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print intermediate alignments
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: cmfile_output
    type: File
    doc: Output covariance model file
    outputBinding:
      glob: '*.out'
  - id: output_align_file
    type:
      - 'null'
      - File
    doc: the output motif structural alignment in stockholm format
    outputBinding:
      glob: $(inputs.output_align_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmfinder:0.4.1.9--pl5.22.0_1
