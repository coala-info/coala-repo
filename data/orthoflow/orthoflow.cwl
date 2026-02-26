cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthoflow
label: orthoflow
doc: "All unrecognized arguments will be passed directly to Snakemake. Use `orthoflow
  --help-snakemake` to list all arguments accepted by Snakemake.\n\nTool homepage:
  https://github.com/rbturnbull/orthoflow"
inputs:
  - id: conda_prefix
    type:
      - 'null'
      - File
    doc: A directory to use for created conda environments. If none given then 
      it will use the user cache directory.
    default: None
    inputBinding:
      position: 101
      prefix: --conda-prefix
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to request for the workflow. If not given then it will 
      use all available available CPU cores.
    default: None
    inputBinding:
      position: 101
      prefix: --cores
  - id: directory
    type:
      - 'null'
      - Directory
    default: .
    inputBinding:
      position: 101
      prefix: --directory
  - id: files
    type:
      - 'null'
      - File
    doc: The input source files
    default: None
    inputBinding:
      position: 101
      prefix: --files
  - id: help_snakemake
    type:
      - 'null'
      - boolean
    doc: Print the snakemake help
    inputBinding:
      position: 101
      prefix: --help-snakemake
  - id: hpc
    type:
      - 'null'
      - boolean
    doc: Run on an HPC cluster (with the SLURM scheduler)?
    inputBinding:
      position: 101
      prefix: --hpc
  - id: install_completion
    type:
      - 'null'
      - boolean
    doc: Install completion for the current shell.
    inputBinding:
      position: 101
      prefix: --install-completion
  - id: no_hpc
    type:
      - 'null'
      - boolean
    doc: Run on an HPC cluster (with the SLURM scheduler)?
    inputBinding:
      position: 101
      prefix: --no-hpc
  - id: show_completion
    type:
      - 'null'
      - boolean
    doc: Show completion for the current shell, to copy it or customize the 
      installation.
    inputBinding:
      position: 101
      prefix: --show-completion
outputs:
  - id: target
    type:
      - 'null'
      - File
    doc: The target file to create
    outputBinding:
      glob: $(inputs.target)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthoflow:0.3.4--pyhdfd78af_0
