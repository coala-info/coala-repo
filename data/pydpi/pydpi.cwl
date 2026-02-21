cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydpi
label: pydpi
doc: "The provided text does not contain help information for the pydpi tool; it contains
  error logs from a container runtime (Apptainer/Singularity) attempting to fetch
  the pydpi image.\n\nTool homepage: http://cbdd.csu.edu.cn/index"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydpi:1.0--py_0
stdout: pydpi.out
