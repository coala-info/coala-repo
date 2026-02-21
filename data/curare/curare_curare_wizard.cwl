cwlVersion: v1.2
class: CommandLineTool
baseCommand: curare_curare_wizard
label: curare_curare_wizard
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/pblumenkamp/Curare"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curare:0.6.0--pyhdfd78af_0
stdout: curare_curare_wizard.out
