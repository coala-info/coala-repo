cwlVersion: v1.2
class: CommandLineTool
baseCommand: msoma
label: msoma
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/AkeyLab/mSOMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0
stdout: msoma.out
