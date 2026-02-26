cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - abort
label: cromshell_abort
doc: "Abort a running workflow.\n\nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: workflow_ids
    type:
      type: array
      items: string
    doc: Workflow ID can be one or more workflow ids belonging to a running 
      workflow separated by a space (e.g. abort [workflow_id1] 
      [[workflow_id2]...]).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_abort.out
