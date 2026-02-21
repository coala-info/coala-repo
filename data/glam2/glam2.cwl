cwlVersion: v1.2
class: CommandLineTool
baseCommand: glam2
label: glam2
doc: "The provided text does not contain help information for glam2; it contains error
  messages related to a container runtime (Apptainer/Singularity) failing to pull
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/nameisjin/glam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/glam2:v1064-5-deb_cv1
stdout: glam2.out
