cwlVersion: v1.2
class: CommandLineTool
baseCommand: strcount
label: strcount
doc: "A tool for counting short tandem repeats (STRs). (Note: The provided text is
  a container build error log and does not contain usage information or argument definitions.)\n
  \nTool homepage: https://github.com/sabiqali/strcount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strcount:0.1.1--py312h7e72e81_2
stdout: strcount.out
