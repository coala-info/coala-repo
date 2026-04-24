cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakesee status
label: snakesee_status
doc: "Show a one-time status snapshot (non-interactive).\n\nUseful for scripting or
  quick checks.\n\nTool homepage: https://github.com/nh13/snakesee"
inputs:
  - id: workflow_dir
    type:
      - 'null'
      - Directory
    doc: Path to workflow directory containing .snakemake/.
    inputBinding:
      position: 1
  - id: no_estimate
    type:
      - 'null'
      - boolean
    doc: Disable time estimation from historical data.
    inputBinding:
      position: 102
      prefix: --no-estimate
  - id: profile
    type:
      - 'null'
      - string
    doc: Optional path to a timing profile for bootstrapping estimates.
    inputBinding:
      position: 102
      prefix: --profile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
stdout: snakesee_status.out
