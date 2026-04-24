cwlVersion: v1.2
class: CommandLineTool
baseCommand: mltrain
label: consan_strain_ml
doc: "Train models for consan_strain using training set files.\n\nTool homepage: http://eddylab.org/software/consan/"
inputs:
  - id: training_set_files
    type:
      type: array
      items: File
    doc: Training set files
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debugging output
    inputBinding:
      position: 102
      prefix: -d
  - id: grammar
    type:
      - 'null'
      - string
    doc: Use grammar <string>, defaults to STA
    inputBinding:
      position: 102
      prefix: -g
  - id: no_weighting
    type:
      - 'null'
      - boolean
    doc: Turn off weighting scheme
    inputBinding:
      position: 102
      prefix: -n
  - id: print_counts
    type:
      - 'null'
      - boolean
    doc: print out counts used for model
    inputBinding:
      position: 102
      prefix: -q
  - id: print_parameters
    type:
      - 'null'
      - boolean
    doc: print out parameters of model
    inputBinding:
      position: 102
      prefix: -x
  - id: recalculate_weights
    type:
      - 'null'
      - boolean
    doc: Force recalculate weights (defaults to given when available)
    inputBinding:
      position: 102
      prefix: -c
  - id: traceback
    type:
      - 'null'
      - boolean
    doc: print traceback
    inputBinding:
      position: 102
      prefix: -t
  - id: tying_type
    type:
      - 'null'
      - int
    doc: Setup Tying Type [No tying = 0; NT counts = 1; Gap Open/Extend counts = 2;
      Gap Open/Extend probs = 3; LR Symmetry 4 (default)]
    inputBinding:
      position: 102
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: -v
  - id: voronoi_weights
    type:
      - 'null'
      - boolean
    doc: Use Voronoi weights instead of GSC
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: save_model
    type:
      - 'null'
      - File
    doc: save model file to <file>
    outputBinding:
      glob: $(inputs.save_model)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consan:1.2--h7b50bb2_7
