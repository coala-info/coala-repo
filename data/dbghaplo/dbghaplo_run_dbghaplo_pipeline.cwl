cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbghaplo
label: dbghaplo_run_dbghaplo_pipeline
doc: "A pipeline tool for dbghaplo (Note: The provided help text contains only system
  error logs and no usage information).\n\nTool homepage: https://github.com/bluenote-1577/dbghaplo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbghaplo:0.0.2--ha6fb395_1
stdout: dbghaplo_run_dbghaplo_pipeline.out
