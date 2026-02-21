cwlVersion: v1.2
class: CommandLineTool
baseCommand: irma
label: irma
doc: "The provided text does not contain help information for the tool 'irma'. It
  consists of error messages related to a container runtime (Apptainer/Singularity)
  failing to pull an image due to insufficient disk space.\n\nTool homepage: https://wonder.cdc.gov/amd/flu/irma/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irma:1.2.0--pl5321hdfd78af_0
stdout: irma.out
