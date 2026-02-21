cwlVersion: v1.2
class: CommandLineTool
baseCommand: ice-cream
label: ice-cream
doc: "The provided text does not contain help information or usage instructions for
  the tool 'ice-cream'. It contains system log messages and a fatal error regarding
  container image building (no space left on device).\n\nTool homepage: https://github.com/xinehc/ICEcream"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ice-cream:2.0.0--pyh10911b7_0
stdout: ice-cream.out
