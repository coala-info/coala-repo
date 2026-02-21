cwlVersion: v1.2
class: CommandLineTool
baseCommand: nifflr
label: nifflr
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container environment (Apptainer/Singularity)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/alguoo314/NIFFLR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nifflr:2.0.0--pl5321haf24da9_0
stdout: nifflr.out
