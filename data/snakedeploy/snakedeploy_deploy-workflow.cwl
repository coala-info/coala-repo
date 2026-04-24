cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakedeploy deploy-workflow
label: snakedeploy_deploy-workflow
doc: "Deploy a workflow from a git repository.\n\nTool homepage: https://github.com/snakemake/snakedeploy"
inputs:
  - id: repo
    type: string
    doc: Workflow repository to use.
    inputBinding:
      position: 1
  - id: dest
    type: Directory
    doc: Path to create the deploying workflow in.
    inputBinding:
      position: 2
  - id: branch
    type:
      - 'null'
      - string
    doc: Git branch to deploy from.
    inputBinding:
      position: 103
      prefix: --branch
  - id: force
    type:
      - 'null'
      - boolean
    doc: Enforce overwriting of already present files.
    inputBinding:
      position: 103
      prefix: --force
  - id: name
    type:
      - 'null'
      - string
    doc: The name for the module in the resulting Snakefile
    inputBinding:
      position: 103
      prefix: --name
  - id: tag
    type:
      - 'null'
      - string
    doc: Git tag to deploy from (e.g. a certain release).
    inputBinding:
      position: 103
      prefix: --tag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
stdout: snakedeploy_deploy-workflow.out
