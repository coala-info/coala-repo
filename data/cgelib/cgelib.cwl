cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgelib
label: cgelib
doc: "The provided text does not contain help information or usage instructions for
  cgelib; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or extract the image due to lack of disk space.\n\nTool homepage:
  https://genomicepidemiology.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgelib:0.7.5--pyhdfd78af_0
stdout: cgelib.out
