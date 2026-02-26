cwlVersion: v1.2
class: CommandLineTool
baseCommand: curare.py
label: curare
doc: "Customizable and Reproducible Analysis Pipeline for RNA-Seq Experiments (Curare).\n\
  \nTool homepage: https://github.com/pblumenkamp/Curare"
inputs:
  - id: conda_frontend
    type:
      - 'null'
      - string
    doc: Choose conda frontend for creating and installing conda environments 
      (conda, mamba)
    default: mamba
    inputBinding:
      position: 101
      prefix: --conda-frontend
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: 'The directory in which conda environments will be created. Relative paths
      will be relative to output folder! (Default: Output_folder)'
    inputBinding:
      position: 101
      prefix: --conda-prefix
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of threads/cores.
    inputBinding:
      position: 101
      prefix: --cores
  - id: create_conda_envs_only
    type:
      - 'null'
      - boolean
    doc: Only download and create conda environments.
    inputBinding:
      position: 101
      prefix: --create-conda-envs-only
  - id: keep_going
    type:
      - 'null'
      - boolean
    doc: Keep going with individual jobs if a job fails.
    inputBinding:
      position: 101
      prefix: --keep-going
  - id: latency_wait
    type:
      - 'null'
      - int
    doc: Seconds to wait before checking if all files of a rule were created.
    default: 5
    inputBinding:
      position: 101
      prefix: --latency-wait
  - id: no_conda
    type:
      - 'null'
      - boolean
    doc: Don't use Conda/Mamba for the installation of module tools. (All tools 
      necessary must be installed manually in advance)
    inputBinding:
      position: 101
      prefix: --no-conda
  - id: pipeline_file
    type: File
    doc: File containing information about the RNA-seq pipeline
    inputBinding:
      position: 101
      prefix: --pipeline
  - id: samples_file
    type: File
    doc: File containing information about each sample
    inputBinding:
      position: 101
      prefix: --samples
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: DEPRECATED, BY DEFAULT ON - Install and use separate conda environments
      for pipeline modules
    inputBinding:
      position: 101
      prefix: --use-conda
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_folder
    type: Directory
    doc: Output folder (will be created if not existing)
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curare:0.6.0--pyhdfd78af_0
