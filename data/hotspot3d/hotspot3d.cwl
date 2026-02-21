cwlVersion: v1.2
class: CommandLineTool
baseCommand: hotspot3d
label: hotspot3d
doc: "The provided text does not contain help information for hotspot3d; it contains
  system error messages regarding a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
stdout: hotspot3d.out
