cwlVersion: v1.2
class: CommandLineTool
baseCommand: openpyxl
label: openpyxl
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the image due to insufficient disk space.\n
  \nTool homepage: https://github.com/ericgazoni/openpyxl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openpyxl:2.4.0--py35_0
stdout: openpyxl.out
