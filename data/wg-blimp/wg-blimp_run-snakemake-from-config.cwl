cwlVersion: v1.2
class: CommandLineTool
baseCommand: wg-blimp run-snakemake-from-config
label: wg-blimp_run-snakemake-from-config
doc: "Run the snakemake pipeline using a config file.\n\nTool homepage: https://github.com/MarWoes/wg-blimp"
inputs:
  - id: config_yaml
    type: File
    doc: Configuration YAML file
    inputBinding:
      position: 1
  - id: cluster
    type:
      - 'null'
      - string
    doc: Submission command snakemake uses for cluster usage. Setting this 
      parameter enables snakemake's cluster mode.
    inputBinding:
      position: 102
      prefix: --cluster
  - id: cores
    type: int
    doc: The maximum number of cores to use for running the pipeline. Cores per 
      job are set in configuration file. In cluster mode, this sets cores used 
      per node.
    inputBinding:
      position: 102
      prefix: --cores
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Only dry-run the workflow.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: nodes
    type:
      - 'null'
      - int
    doc: Number of nodes to use in cluster mode.
    inputBinding:
      position: 102
      prefix: --nodes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wg-blimp:0.10.0--pyh5e36f6f_0
stdout: wg-blimp_run-snakemake-from-config.out
