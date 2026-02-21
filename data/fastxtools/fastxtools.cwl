cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastxtools
label: fastxtools
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to pull or build the container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/AliciaMstt/fastxtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastxtools:v0.0.14_cv2
stdout: fastxtools.out
