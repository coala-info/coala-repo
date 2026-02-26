cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - alias
label: cromshell_alias
doc: "Label the given workflow ID or relative id with the given alias. Aliases can
  be used in place of workflow IDs to reference jobs.\n\nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: workflow_id
    type: string
    doc: Workflow ID or relative ID to label
    inputBinding:
      position: 1
  - id: alias
    type: string
    doc: The alias to assign. Remove alias by passing empty double quotes.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_alias.out
