cwlVersion: v1.2
class: CommandLineTool
baseCommand: 7zz
label: p7zip_7zz
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or run the container due to insufficient disk space.\n\nTool
  homepage: https://github.com/p7zip-project/p7zip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/p7zip:16.02
stdout: p7zip_7zz.out
