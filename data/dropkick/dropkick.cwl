cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropkick
label: dropkick
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/KenLauLab/dropkick"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropkick:1.2.8--py310h7eb0018_0
stdout: dropkick.out
