cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpfstats
label: admixtools_qpfstats
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a Singularity/Apptainer
  container image due to insufficient disk space ('no space left on device').\n\n
  Tool homepage: https://github.com/DReichLab/AdmixTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpfstats.out
