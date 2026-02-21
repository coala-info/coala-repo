cwlVersion: v1.2
class: CommandLineTool
baseCommand: snippy
label: snippy
doc: "The provided text is a container runtime error log and does not contain the
  help documentation or usage instructions for the tool 'snippy'.\n\nTool homepage:
  https://github.com/tseemann/snippy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snippy:4.6.0--hdfd78af_6
stdout: snippy.out
