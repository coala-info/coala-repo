cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - baczy
  - run
label: baczy_run
doc: "Run baczy\n\nTool homepage: https://github.com/npbhavya/baczy/"
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
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file
    default: (outputDir)/config.yaml
    inputBinding:
      position: 102
      prefix: --configfile
  - id: input
    type: string
    doc: Input file/directory
    inputBinding:
      position: 102
      prefix: --input
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: true
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: no_use_singularity
    type:
      - 'null'
      - boolean
    doc: Use containers for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-singularity
  - id: profile
    type:
      - 'null'
      - string
    doc: Snakemake profile to use
    inputBinding:
      position: 102
      prefix: --profile
  - id: sequencing
    type:
      - 'null'
      - string
    doc: sequencing method
    default: paired
    inputBinding:
      position: 102
      prefix: --sequencing
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
    default: --printshellcmds, --nolock, --show-failed-logs
    inputBinding:
      position: 102
      prefix: --snake-default
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
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
  - id: use_singularity
    type:
      - 'null'
      - boolean
    doc: Use containers for Snakemake rules
    default: true
    inputBinding:
      position: 102
      prefix: --use-singularity
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baczy:1.0.3--pyhdfd78af_0
