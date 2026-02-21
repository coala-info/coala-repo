cwlVersion: v1.2
class: CommandLineTool
baseCommand: saspector
label: saspector
doc: "A tool for analyzing and inspecting SAS datasets (Note: The provided text contains
  only container build logs and error messages, not the actual help documentation).\n
  \nTool homepage: https://github.com/alejocrojo09/SASpector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/saspector:0.0.5--pyhdfd78af_0
stdout: saspector.out
