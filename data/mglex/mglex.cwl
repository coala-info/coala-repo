cwlVersion: v1.2
class: CommandLineTool
baseCommand: mglex
label: mglex
doc: "The provided text does not contain help information for the tool. It appears
  to be a set of error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to lack of disk space.\n\nTool
  homepage: https://github.com/fungs/mglex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mglex:0.2.1--py_0
stdout: mglex.out
