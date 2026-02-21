cwlVersion: v1.2
class: CommandLineTool
baseCommand: inheritance
label: inheritance
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/brentp/inheritance"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/inheritance:0.1.5--py_0
stdout: inheritance.out
