cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reneo
  - config
label: reneo_config
doc: "Copy the system default config file\n\nTool homepage: https://github.com/Vini2/phables"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --output
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file [default - (outputDir)/config.yaml]
    inputBinding:
      position: 102
      prefix: --configfile
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Do not use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: conda_prefix
    type:
      - 'null'
      - string
    doc: Custom conda env directory
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
    inputBinding:
      position: 102
      prefix: --snake-default
  - id: profile
    type:
      - 'null'
      - string
    doc: Snakemake profile to use
    inputBinding:
      position: 102
      prefix: --profile
outputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Copied configuration file
    outputBinding:
      glob: $(inputs.configfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reneo:0.5.0--pyhdfd78af_0
