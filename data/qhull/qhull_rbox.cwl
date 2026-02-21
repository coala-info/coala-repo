cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbox
label: qhull_rbox
doc: "The provided text does not contain help information for the tool. It is a fatal
  error message from a container runtime (Apptainer/Singularity) indicating a failure
  to fetch or build the OCI image.\n\nTool homepage: https://github.com/qhull/qhull"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhull:2015.2--h2d50403_0
stdout: qhull_rbox.out
