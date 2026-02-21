cwlVersion: v1.2
class: CommandLineTool
baseCommand: showali
label: showali
doc: "The provided text does not contain help information for the tool 'showali'.
  It contains error logs from a container runtime (Apptainer/Singularity) attempting
  to fetch the tool's image.\n\nTool homepage: https://github.com/kirilenkobm/showali"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/showali:1.0.1--h7b50bb2_0
stdout: showali.out
