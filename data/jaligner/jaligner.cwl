cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaligner
label: jaligner
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for the tool 'jaligner'. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/ahmedmoustafa/JAligner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jaligner:v1.0dfsg-6-deb_cv1
stdout: jaligner.out
