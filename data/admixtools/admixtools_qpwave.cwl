cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpwave
label: admixtools_qpwave
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract a Singularity/Apptainer container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/DReichLab/AdmixTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpwave.out
