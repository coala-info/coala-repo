cwlVersion: v1.2
class: CommandLineTool
baseCommand: GraphAligner
label: graphaligner
doc: "The provided text does not contain help information for GraphAligner; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/maickrau/GraphAligner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphaligner:1.0.20--h06902ac_1
stdout: graphaligner.out
