cwlVersion: v1.2
class: CommandLineTool
baseCommand: imagej
label: imagej
doc: "ImageJ is a Java-based image processing program. (Note: The provided text contains
  error messages regarding container execution and does not list CLI arguments.)\n
  \nTool homepage: https://github.com/imagej/imagej2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/imagej:v1.51idfsg-2-deb_cv1
stdout: imagej.out
