cwlVersion: v1.2
class: CommandLineTool
baseCommand: isaslicer
label: isaslicer
doc: "The provided text contains error logs from a container runtime (Apptainer/Singularity)
  and does not include the help documentation for isaslicer. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/phnmnl/container-isaslicer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isaslicer:phenomenal-v0.9.5_cv0.1.0.1
stdout: isaslicer.out
