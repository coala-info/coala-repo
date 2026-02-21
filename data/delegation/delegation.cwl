cwlVersion: v1.2
class: CommandLineTool
baseCommand: delegation
label: delegation
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) attempting
  to pull the delegation image.\n\nTool homepage: https://github.com/symonsoft/delegation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/delegation:1.1--py_0
stdout: delegation.out
