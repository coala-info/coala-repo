cwlVersion: v1.2
class: CommandLineTool
baseCommand: textinput
label: textinput
doc: "A tool for text input processing (Note: The provided text appears to be a container
  build log rather than help text; no arguments could be extracted).\n\nTool homepage:
  http://www.ebi.ac.uk/~hoffman/software/textinput/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/textinput:0.2--py_0
stdout: textinput.out
