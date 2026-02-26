cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakedeploy
label: snakedeploy_from
doc: "Deploy Snakemake workflows and manage their environments.\n\nTool homepage:
  https://github.com/snakemake/snakedeploy"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to execute. Available subcommands: deploy-workflow, collect-files,
      pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin'
    inputBinding:
      position: 1
  - id: log_disable_color
    type:
      - 'null'
      - boolean
    doc: Disable colorized log output.
    inputBinding:
      position: 102
      prefix: --log-disable-color
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output messages.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
stdout: snakedeploy_from.out
