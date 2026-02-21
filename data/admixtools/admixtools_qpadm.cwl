cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpAdm
label: admixtools_qpadm
doc: "The provided text is a system error log indicating a container build failure
  (no space left on device) and does not contain CLI help information or argument
  definitions.\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpadm.out
