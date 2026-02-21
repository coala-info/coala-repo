cwlVersion: v1.2
class: CommandLineTool
baseCommand: iscc-sum
label: iscc-sum
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/bio-codes/iscc-sum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iscc-sum:0.1.0--py314hc1c3326_0
stdout: iscc-sum.out
