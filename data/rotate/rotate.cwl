cwlVersion: v1.2
class: CommandLineTool
baseCommand: rotate
label: rotate
doc: "The provided text does not contain help information or usage instructions for
  the tool 'rotate'. It contains error logs related to a container build process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/richarddurbin/rotate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rotate:1.0--h577a1d6_1
stdout: rotate.out
