cwlVersion: v1.2
class: CommandLineTool
baseCommand: pp-popularity-contest
label: pp-popularity-contest
doc: The provided text contains system error messages related to a failed 
  container build and does not include the tool's help documentation or usage 
  instructions. As a result, no arguments could be extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pp-popularity-contest:v1.0.6-2b4-deb_cv1
stdout: pp-popularity-contest.out
