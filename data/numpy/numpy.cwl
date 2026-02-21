cwlVersion: v1.2
class: CommandLineTool
baseCommand: numpy
label: numpy
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain CLI help information or arguments for the tool.\n\nTool homepage:
  https://github.com/numpy/numpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/numpy:2.2.2
stdout: numpy.out
