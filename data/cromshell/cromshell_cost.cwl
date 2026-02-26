cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - cost
label: cromshell_cost
doc: "Get the cost for a workflow. Only works for workflows that completed more than
  24 hours ago on GCS. Requires the 'bq_cost_table' key in the cromshell configuration
  file to be set to the big query cost table for your organization.\n\nCosts here
  DO NOT include any call cached tasks. Costs rounded to the nearest cent (approximately).\n\
  \nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: workflow_ids
    type:
      type: array
      items: string
    doc: Workflow IDs to get cost for
    inputBinding:
      position: 1
  - id: color
    type:
      - 'null'
      - boolean
    doc: Color outliers in task level cost results.
    inputBinding:
      position: 102
      prefix: --color
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: Get the cost for a workflow at the task level
    inputBinding:
      position: 102
      prefix: --detailed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_cost.out
