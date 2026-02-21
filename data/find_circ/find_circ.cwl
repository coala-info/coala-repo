cwlVersion: v1.2
class: CommandLineTool
baseCommand: find_circ
label: find_circ
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/marvin-jens/find_circ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/find_differential_primers:0.1.4--py_0
stdout: find_circ.out
