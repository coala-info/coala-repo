cwlVersion: v1.2
class: CommandLineTool
baseCommand: kitsune
label: kitsune
doc: "The provided text is an error log from a container runtime and does not contain
  help information or argument definitions for the tool 'kitsune'.\n\nTool homepage:
  https://github.com/natapol/kitsune"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kitsune:1.3.5--pyhdfd78af_0
stdout: kitsune.out
