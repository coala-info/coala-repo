cwlVersion: v1.2
class: CommandLineTool
baseCommand: ezomero
label: ezomero
doc: "The provided text does not contain help information or usage instructions for
  ezomero; it contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to lack of disk space.\n\nTool homepage: https://github.com/TheJacksonLaboratory/ezomero"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezomero:3.2.2--pyhdfd78af_0
stdout: ezomero.out
