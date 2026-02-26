cwlVersion: v1.2
class: CommandLineTool
baseCommand: repic_iter_pick
label: repic_iter_pick
doc: "Iteratively pick particles based on a configuration file.\n\nTool homepage:
  https://github.com/ccameron/REPIC"
inputs:
  - id: config_file
    type: File
    doc: path to REPIC config file
    inputBinding:
      position: 1
  - id: num_iter
    type: int
    doc: number of iterations (int)
    inputBinding:
      position: 2
  - id: train_size
    type: int
    doc: training subset percentage (int)
    inputBinding:
      position: 3
  - id: sample_prob
    type:
      - 'null'
      - float
    doc: sampling probability of initial training labels for 'semi_auto'
    default: 1.0
    inputBinding:
      position: 104
      prefix: --sample_prob
  - id: score
    type:
      - 'null'
      - boolean
    doc: evaluate picked particle sets
    inputBinding:
      position: 104
      prefix: --score
  - id: semi_auto
    type:
      - 'null'
      - boolean
    doc: initialize training labels with known particles (semi-automatic)
    inputBinding:
      position: 104
      prefix: --semi_auto
outputs:
  - id: out_file_path
    type:
      - 'null'
      - File
    doc: path for picking log file
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
