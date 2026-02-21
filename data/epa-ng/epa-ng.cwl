cwlVersion: v1.2
class: CommandLineTool
baseCommand: epa-ng
label: epa-ng
doc: "The provided text does not contain help information for epa-ng; it is an error
  log indicating a failure to build a SIF container due to lack of disk space.\n\n
  Tool homepage: https://github.com/Pbdas/epa-ng"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epa-ng:0.3.8--he513fc3_0
stdout: epa-ng.out
