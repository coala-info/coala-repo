cwlVersion: v1.2
class: CommandLineTool
baseCommand: krona
label: krona
doc: "Krona allows hierarchical data to be explored with zooming, multi-layered pie
  charts. (Note: The provided text is a system error message and does not contain
  command-line usage or argument definitions.)\n\nTool homepage: https://github.com/marbl/Krona"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona.out
