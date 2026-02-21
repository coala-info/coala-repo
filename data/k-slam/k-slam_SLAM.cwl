cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - k-slam
  - SLAM
label: k-slam_SLAM
doc: "The provided text contains system error messages related to a container environment
  (Apptainer/Singularity) and does not contain the help documentation for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/aindj/k-SLAM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/k-slam:1.0--1
stdout: k-slam_SLAM.out
