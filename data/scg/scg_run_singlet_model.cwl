cwlVersion: v1.2
class: CommandLineTool
baseCommand: scg_run_singlet_model
label: scg_run_singlet_model
doc: "Run the singlet model for Single Cell Genotyper.\n\nTool homepage: https://bitbucket.org/aroth85/scg/wiki/Home"
inputs:
  - id: config_file
    type: File
    doc: Path to YAML format configuration file.
    inputBinding:
      position: 101
      prefix: --config_file
  - id: convergence_tolerance
    type:
      - 'null'
      - float
    doc: Convergence tolerance for the model.
    inputBinding:
      position: 101
      prefix: --convergence_tolerance
  - id: labels_file
    type:
      - 'null'
      - File
    doc: Path of file with initial labels to use.
    inputBinding:
      position: 101
      prefix: --labels_file
  - id: max_num_iters
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for the model.
    inputBinding:
      position: 101
      prefix: --max_num_iters
  - id: samples_file
    type:
      - 'null'
      - File
    doc: Path mapping cells to samples. If set each sample will have a separate 
      mixing proportion.
    inputBinding:
      position: 101
      prefix: --samples_file
  - id: seed
    type:
      - 'null'
      - int
    doc: Set random seed so results can be reproduced. By default a random seed 
      is chosen.
    inputBinding:
      position: 101
      prefix: --seed
  - id: use_position_specific_error_rate
    type:
      - 'null'
      - boolean
    doc: If an error rate will be estimated for each position.
    inputBinding:
      position: 101
      prefix: --use_position_specific_error_rate
outputs:
  - id: lower_bound_file
    type:
      - 'null'
      - File
    doc: Path of file where lower bound will be written.
    outputBinding:
      glob: $(inputs.lower_bound_file)
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Path where output files will be written.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scg:0.3.1--py27_0
