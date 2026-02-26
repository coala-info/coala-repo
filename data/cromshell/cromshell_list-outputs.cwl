cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - list-outputs
label: cromshell_list-outputs
doc: "List all output files produced by a workflow.\n\nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: workflow_ids
    type:
      type: array
      items: string
    doc: Workflow IDs to list outputs for
    inputBinding:
      position: 1
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: Get the output for a workflow at the task level
    inputBinding:
      position: 102
      prefix: --detailed
  - id: json_summary
    type:
      - 'null'
      - boolean
    doc: Print a json summary of outputs, including non-file types.
    inputBinding:
      position: 102
      prefix: --json-summary
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_list-outputs.out
