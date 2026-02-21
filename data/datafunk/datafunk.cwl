cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk
label: datafunk
doc: "The provided text is a system error log regarding a container build failure
  and does not contain help text or usage information for the tool 'datafunk'.\n\n
  Tool homepage: https://github.com/cov-ert/datafunk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
stdout: datafunk.out
