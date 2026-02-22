cwlVersion: v1.2
class: CommandLineTool
baseCommand: borf
label: borf
doc: "The provided text does not contain help information or usage instructions for
  the tool 'borf'. It contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull an image due to insufficient disk space.\n\
  \nTool homepage: https://github.com/betsig/borf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/borf:1.2--py_0
stdout: borf.out
