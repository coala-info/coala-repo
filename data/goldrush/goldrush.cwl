cwlVersion: v1.2
class: CommandLineTool
baseCommand: goldrush
label: goldrush
doc: "GoldRush is a de novo genome assembler. (Note: The provided text contains system
  error logs and does not include the tool's help documentation; therefore, arguments
  could not be extracted.)\n\nTool homepage: https://github.com/bcgsc/goldrush"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0
stdout: goldrush.out
