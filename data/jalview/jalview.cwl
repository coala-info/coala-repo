cwlVersion: v1.2
class: CommandLineTool
baseCommand: jalview
label: jalview
doc: "Jalview is a tool for multiple sequence alignment editing, visualization, and
  analysis. (Note: The provided text contains container runtime error messages and
  does not list specific command-line arguments.)\n\nTool homepage: http://www.jalview.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jalview:2.11.5.1--hdfd78af_0
stdout: jalview.out
