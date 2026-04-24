cwlVersion: v1.2
class: CommandLineTool
baseCommand: backspinpy_backspin
label: backspinpy_backspin
doc: "backSPIN commandline tool\n\nTool homepage: https://github.com/linnarsson-lab/BackSPIN"
inputs:
  - id: avg_expression_threshold
    type:
      - 'null'
      - float
    doc: "If the difference between the average expression of two groups is lower
      than threshold the algorythm \n              uses higly correlated genes to
      assign the gene to one of the two groups"
    inputBinding:
      position: 101
      prefix: -r
  - id: depth
    type: int
    doc: 'Depth/Number of levels: The number of nested splits that will be tried by
      the algorithm'
    inputBinding:
      position: 101
      prefix: -d
  - id: feature_selection_genes
    type:
      - 'null'
      - int
    doc: "Feature selection is performed before BackSPIN. Argument controls how many
      genes are seleceted.\n              Selection is based on expected noise (a
      curve fit to the CV-vs-mean plot)."
    inputBinding:
      position: 101
      prefix: -f
  - id: input_file
    type: File
    doc: "Path of the cef formatted tab delimited file.\n              Rows should
      be genes and columns single cells/samples.\n              For further information
      on the cef format visit:\n              https://github.com/linnarsson-lab/ceftools"
    inputBinding:
      position: 101
      prefix: --input
  - id: min_cells_per_group
    type:
      - 'null'
      - int
    doc: Minimal number of cells that a group must contain for splitting to be 
      allowed.
    inputBinding:
      position: 101
      prefix: -c
  - id: min_genes_per_group
    type:
      - 'null'
      - int
    doc: Minimal number of genes that a group must contain for splitting to be 
      allowed.
    inputBinding:
      position: 101
      prefix: -g
  - id: min_split_score
    type:
      - 'null'
      - float
    doc: Minimum score that a breaking point has to reach to be suitable for 
      splitting.
    inputBinding:
      position: 101
      prefix: -k
  - id: prep_spin_iterations
    type:
      - 'null'
      - int
    doc: Number of the iterations used in the preparatory SPIN.
    inputBinding:
      position: 101
      prefix: -t
  - id: prep_spin_width_decrease_rate
    type:
      - 'null'
      - float
    doc: "Controls the decrease rate of the width parameter used in the preparatory
      SPIN.\n              Smaller values will increase the number of SPIN iterations
      and result in higher \n              precision in the first step but longer
      execution time."
    inputBinding:
      position: 101
      prefix: -s
  - id: run_normal_spin
    type:
      - 'null'
      - string
    doc: "Run normal SPIN instead of backSPIN.\n              Normal spin accepts
      the parameters -T -S\n              An axis value 0 to only sort genes (rows),
      1 to only sort cells (columns) or 'both' for both\n              must be passed"
    inputBinding:
      position: 101
      prefix: -b
  - id: spin_iterations_per_width
    type:
      - 'null'
      - int
    doc: "Number of the iterations used for every width parameter.\n             \
      \ Does not apply on the first run (use -t instead)"
    inputBinding:
      position: 101
      prefix: -T
  - id: spin_width_decrease_rate
    type:
      - 'null'
      - float
    doc: "Controls the decrease rate of the width parameter.\n              Smaller
      values will increase the number of SPIN iterations and result in higher \n \
      \             precision but longer execution time.\n              Does not apply
      on the first run (use -s instead)"
    inputBinding:
      position: 101
      prefix: -S
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose. Print  to the stdoutput extra details of what is happening
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: The name of the file to which the output will be written
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/backspinpy:0.2.1--pyh24bf2e0_1
