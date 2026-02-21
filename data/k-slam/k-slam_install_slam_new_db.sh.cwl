cwlVersion: v1.2
class: CommandLineTool
baseCommand: k-slam_install_slam_new_db.sh
label: k-slam_install_slam_new_db.sh
doc: "Install a new database for K-SLAM (Note: The provided text contains only system
  error logs and no usage information or arguments).\n\nTool homepage: https://github.com/aindj/k-SLAM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/k-slam:1.0--1
stdout: k-slam_install_slam_new_db.sh.out
