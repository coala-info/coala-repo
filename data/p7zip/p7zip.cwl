cwlVersion: v1.2
class: CommandLineTool
baseCommand: p7zip
label: p7zip
doc: "The provided text does not contain help information for p7zip; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/p7zip-project/p7zip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/p7zip:16.02
stdout: p7zip.out
