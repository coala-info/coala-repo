cwlVersion: v1.2
class: CommandLineTool
baseCommand: amrfior
label: amrfior
doc: "The provided text is a system error log regarding a failed container build (no
  space left on device) and does not contain the help documentation for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/NickJD/AMRfior"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amrfior:0.5.0--pyhdfd78af_0
stdout: amrfior.out
