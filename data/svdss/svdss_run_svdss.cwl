cwlVersion: v1.2
class: CommandLineTool
baseCommand: svdss
label: svdss_run_svdss
doc: "Structural variant discovery from sparse sequencing (Note: The provided text
  contains container runtime errors and does not include usage information or argument
  definitions).\n\nTool homepage: https://github.com/Parsoa/SVDSS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdss:2.1.0--h9013031_0
stdout: svdss_run_svdss.out
