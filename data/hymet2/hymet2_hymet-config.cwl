cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet-config
label: hymet2_hymet-config
doc: "Configuration tool for HyMet2 (Note: The provided text contains container runtime
  error logs rather than tool help documentation)\n\nTool homepage: https://github.com/inesbmartins02/HYMET2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet2:1.0.0--hdfd78af_0
stdout: hymet2_hymet-config.out
