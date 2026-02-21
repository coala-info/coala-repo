cwlVersion: v1.2
class: CommandLineTool
baseCommand: pisad
label: pisad
doc: "The provided text does not contain help information or usage instructions for
  the tool 'pisad'. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/ZhantianXu/PISAD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
stdout: pisad.out
