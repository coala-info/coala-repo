cwlVersion: v1.2
class: CommandLineTool
baseCommand: codingorf
label: codingorf
doc: "A tool for identifying coding Open Reading Frames (ORFs). Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/Woosub-Kim/codingorf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codingorf:v1.0.0--pyh5e36f6f_0
stdout: codingorf.out
