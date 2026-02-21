cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaligner
label: jaligner_java
doc: "JAligner is a Java implementation of the Smith-Waterman algorithm for biological
  local pairwise sequence alignment. (Note: The provided help text contains system
  error messages regarding container image conversion and does not list specific command-line
  arguments).\n\nTool homepage: https://github.com/ahmedmoustafa/JAligner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jaligner:v1.0dfsg-6-deb_cv1
stdout: jaligner_java.out
