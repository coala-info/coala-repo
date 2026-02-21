cwlVersion: v1.2
class: CommandLineTool
baseCommand: desalt
label: desalt
doc: "The provided text does not contain help information for the tool 'desalt'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/ydLiu-HIT/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desalt:1.5.6--h577a1d6_7
stdout: desalt.out
