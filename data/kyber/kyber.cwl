cwlVersion: v1.2
class: CommandLineTool
baseCommand: kyber
label: kyber
doc: "The provided text does not contain help information for the tool 'kyber'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/wdecoster/kyber"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kyber:0.6.0d--ha6fb395_0
stdout: kyber.out
