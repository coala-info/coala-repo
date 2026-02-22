cwlVersion: v1.2
class: CommandLineTool
baseCommand: schemarefinery
label: schemarefinery
doc: "The provided text contains system error messages (Singularity/Docker execution
  errors) rather than the tool's help documentation. As a result, no arguments or
  functional descriptions could be extracted.\n\nTool homepage: https://github.com/B-UMMI/Schema_Refinery"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schemarefinery:0.5.0--pyhdfd78af_0
stdout: schemarefinery.out
