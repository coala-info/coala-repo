cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyspoa
label: pyspoa
doc: "The provided text contains error logs from a container runtime (Singularity/Apptainer)
  and does not include the help documentation for the tool 'pyspoa'. As a result,
  no arguments or functional descriptions could be extracted.\n\nTool homepage: https://github.com/nanoporetech/pyspoa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyspoa:0.3.2--py39h475c85d_0
stdout: pyspoa.out
