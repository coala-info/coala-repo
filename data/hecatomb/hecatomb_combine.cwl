cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hecatomb
  - combine
label: hecatomb_combine
doc: "Combine multiple Hecatomb runs\n\nTool homepage: https://github.com/shandley/hecatomb"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: comb
    type:
      type: array
      items: string
    doc: Two or more Hecatomb output directories to combine. e.g. --comb dir1/ 
      --comb dir2/ ...
    inputBinding:
      position: 102
      prefix: --comb
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
    default: (outputDir)/hecatomb.config.yaml
    inputBinding:
      position: 102
      prefix: --configfile
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: true
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: profile
    type:
      - 'null'
      - string
    doc: Snakemake profile
    inputBinding:
      position: 102
      prefix: --profile
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 32
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: false
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: workflow_profile
    type:
      - 'null'
      - string
    doc: Custom config file
    default: (outputDir)/hecatomb.profile/
    inputBinding:
      position: 102
      prefix: --workflow-profile
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hecatomb:1.3.4--pyh7e72e81_0
