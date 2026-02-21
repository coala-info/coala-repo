cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpDstat
label: admixtools_qpdstat
doc: "The provided text contains error messages related to a container runtime failure
  (no space left on device) rather than the help documentation for qpDstat. No arguments
  could be extracted.\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpdstat.out
