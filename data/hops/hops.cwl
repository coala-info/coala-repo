cwlVersion: v1.2
class: CommandLineTool
baseCommand: hops
label: hops
doc: "The provided text does not contain help information for the tool 'hops'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the tool's image due to insufficient disk space.\n\nTool homepage:
  https://github.com/rhuebler/HOPS/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hops:0.35--hdfd78af_2
stdout: hops.out
