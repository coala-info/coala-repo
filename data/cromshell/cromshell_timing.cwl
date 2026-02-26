cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - timing
label: cromshell_timing
doc: "Analyze and display timing information for a Cromwell workflow.\n\nTool homepage:
  https://github.com/broadinstitute/cromshell"
inputs:
  - id: workflow_id
    type: string
    doc: The ID of the Cromwell workflow to analyze.
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - boolean
    doc: Display additional options for timing analysis.
    inputBinding:
      position: 102
      prefix: --options
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_timing.out
