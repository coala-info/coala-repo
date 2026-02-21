cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzmine
label: mzmine
doc: "The provided text does not contain help information for mzmine; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: http://mzmine.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzmine:4.7.29--hdfd78af_0
stdout: mzmine.out
