cwlVersion: v1.2
class: CommandLineTool
baseCommand: scg_run_dirichlet_mixture_model
label: scg_run_dirichlet_mixture_model
doc: "Run Dirichlet Mixture Model\n\nTool homepage: https://bitbucket.org/aroth85/scg/wiki/Home"
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
    inputBinding:
      position: 101
      prefix: --max_num_iters
  - id: seed
    type:
      - 'null'
      - int
    doc: Set random seed so results can be reproduced. By default a random seed 
      is chosen.
    inputBinding:
      position: 101
      prefix: --seed
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
