cwlVersion: v1.2
class: CommandLineTool
baseCommand: noise2read
label: noise2read
doc: "Noise2Read is a tool for denoising sequencing data.\n\nTool homepage: https://github.com/Jappy0/noise2read"
inputs:
  - id: config
    type: File
    doc: input configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: ground_truth
    type:
      - 'null'
      - File
    doc: input ground truth data if you have
    inputBinding:
      position: 101
      prefix: --true
  - id: high_ambiguous
    type:
      - 'null'
      - boolean
    doc: predict high ambiguous errors using machine learning when set true, 
      defaut true
    inputBinding:
      position: 101
      prefix: --high_ambiguous
  - id: input
    type: File
    doc: input raw data to be corrected
    inputBinding:
      position: 101
      prefix: --input
  - id: module
    type: string
    doc: module selection
    inputBinding:
      position: 101
      prefix: --module
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: set output directory
    inputBinding:
      position: 101
      prefix: --directory
  - id: parallel
    type:
      - 'null'
      - string
    doc: use multiple cpu cores, default total cpu cores - 2
    inputBinding:
      position: 101
      prefix: --parallel
  - id: rectification
    type:
      - 'null'
      - File
    doc: input corrected data when using module evaluation
    inputBinding:
      position: 101
      prefix: --rectification
  - id: tree_method
    type:
      - 'null'
      - string
    doc: use gpu for training and prediction, default auto, (options gpu_hist, 
      hist, auto)
    inputBinding:
      position: 101
      prefix: --tree_method
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noise2read:0.3.0--pyhdfd78af_0
stdout: noise2read.out
