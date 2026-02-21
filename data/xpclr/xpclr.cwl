cwlVersion: v1.2
class: CommandLineTool
baseCommand: xpclr
label: xpclr
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to pull the xpclr image.\n\nTool homepage: https://github.com/hardingnj/xpclr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xpclr:1.1.2--py_0
stdout: xpclr.out
