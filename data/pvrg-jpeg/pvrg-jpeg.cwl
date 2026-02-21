cwlVersion: v1.2
class: CommandLineTool
baseCommand: pvrg-jpeg
label: pvrg-jpeg
doc: "The provided text does not contain help information for pvrg-jpeg; it contains
  a fatal error log from a container engine (Apptainer/Singularity) attempting to
  fetch the tool's image.\n\nTool homepage: https://github.com/deepin-community/pvrg-jpeg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pvrg-jpeg:v1.2.1dfsg1-6-deb_cv1
stdout: pvrg-jpeg.out
