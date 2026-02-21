cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghost-tree
label: ghost-tree
doc: "The provided text does not contain help information for ghost-tree; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/JTFouquier/ghost-tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ghost-tree:0.2.2--py_0
stdout: ghost-tree.out
