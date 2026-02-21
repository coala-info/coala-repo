cwlVersion: v1.2
class: CommandLineTool
baseCommand: msi
label: msi_msi_docker
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help text or usage information for the 'msi' tool. As a result,
  no arguments could be extracted.\n\nTool homepage: http://github.com/nunofonseca/msi/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msi:0.3.8--hdfd78af_0
stdout: msi_msi_docker.out
