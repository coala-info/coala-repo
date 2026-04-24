cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - status
label: cromshell_status
doc: "Check the status of a Cromwell workflow.\n\nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: workflow_id
    type: string
    doc: The ID of the workflow to check the status for.
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to the cromshell configuration file.
    inputBinding:
      position: 102
      prefix: --config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_status.out
