cwlVersion: v1.2
class: CommandLineTool
baseCommand: novobreak
label: novobreak
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image acquisition (no space left on device).\n\nTool homepage: https://github.com/czc/nb_distribution"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novobreak:1.1.3rc--h577a1d6_10
stdout: novobreak.out
