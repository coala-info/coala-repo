cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimnami config
label: trimnami_config
doc: "Copy the system default config file\n\nTool homepage: https://github.com/beardymcjohnface/Trimnami"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Custom conda env directory
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: config_file
    type:
      - 'null'
      - string
    doc: Custom config file
    default: (outputDir)/trimnami.config.yaml
    inputBinding:
      position: 102
      prefix: --configfile
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: false
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: trimnami.out
    inputBinding:
      position: 102
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 8
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: true
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: workflow_profile
    type:
      - 'null'
      - string
    doc: Custom config file
    default: (outputDir)/trimnami.profile/
    inputBinding:
      position: 102
      prefix: --workflow-profile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimnami:0.1.4--pyhdfd78af_0
stdout: trimnami_config.out
