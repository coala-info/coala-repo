cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanonet_siamese_test.py
label: nanonet_siamese_test.py
doc: "The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/abhyantrika/nanonets_object_tracking"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanonet:2.0.0--boost1.64_0
stdout: nanonet_siamese_test.py.out
