cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet-config
label: hymet_hymet-config
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages regarding a container build failure.\n\nTool
  homepage: https://github.com/inesbmartins02/HYMET"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.2.1--hdfd78af_0
stdout: hymet_hymet-config.out
