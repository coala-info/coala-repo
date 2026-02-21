cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgca
label: mgca
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/liaochenlanruo/mgca/blob/master/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgca:0.0.0--pl5321hdfd78af_0
stdout: mgca.out
