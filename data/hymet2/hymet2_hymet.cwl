cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hymet
label: hymet2_hymet
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/inesbmartins02/HYMET2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet2:1.0.0--hdfd78af_0
stdout: hymet2_hymet.out
