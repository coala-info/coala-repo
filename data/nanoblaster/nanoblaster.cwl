cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoblaster
label: nanoblaster
doc: "The provided text does not contain help information for nanoblaster; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/ruhulsbu/NanoBLASTer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoblaster:0.16--h9948957_8
stdout: nanoblaster.out
