cwlVersion: v1.2
class: CommandLineTool
baseCommand: file_markitdown
label: file_markitdown
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/microsoft/markitdown"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/file:5.39
stdout: file_markitdown.out
