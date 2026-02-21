cwlVersion: v1.2
class: CommandLineTool
baseCommand: mwga-utils_metrics
label: mwga-utils_metrics
doc: "Metrics utility for mwga-utils. Note: The provided input text contains container
  runtime error messages rather than the tool's help documentation.\n\nTool homepage:
  https://github.com/RomainFeron/mgwa_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
stdout: mwga-utils_metrics.out
