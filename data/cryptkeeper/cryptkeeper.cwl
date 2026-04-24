cwlVersion: v1.2
class: CommandLineTool
baseCommand: cryptkeeper
label: cryptkeeper
doc: "Pipeline for predicting cryptic gene expression\n\nTool homepage: https://github.com/barricklab/cryptkeeper"
inputs:
  - id: circular
    type:
      - 'null'
      - boolean
    doc: 'The input file is circular. (Note: Increases runtime)'
    inputBinding:
      position: 101
      prefix: --circular
  - id: input_fasta_file
    type: File
    doc: input fasta file
    inputBinding:
      position: 101
      prefix: --input
  - id: no_visualization
    type:
      - 'null'
      - boolean
    doc: Skip visualization
    inputBinding:
      position: 101
      prefix: --no-vis
  - id: output_prefix
    type: string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: plot_only
    type:
      - 'null'
      - boolean
    doc: plot mode, assumes output files all exist
    inputBinding:
      position: 101
      prefix: --plot-only
  - id: rbs_score_cutoff
    type:
      - 'null'
      - float
    doc: Minimum score that is graphed and output to final files (all are used 
      in calculating burden)
    inputBinding:
      position: 101
      prefix: --rbs-score-cutoff
  - id: sample_name
    type:
      - 'null'
      - string
    doc: name of sample (if not provided the filename is used)
    inputBinding:
      position: 101
      prefix: --name
  - id: show_small_orfs
    type:
      - 'null'
      - boolean
    doc: Show small ORFs on visualization
    inputBinding:
      position: 101
      prefix: --show-small
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads/processes to use
    inputBinding:
      position: 101
      prefix: -threads
  - id: tick_frequency
    type:
      - 'null'
      - int
    doc: Y axis tick frequency
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cryptkeeper:1.0.1--pyhdfd78af_0
stdout: cryptkeeper.out
