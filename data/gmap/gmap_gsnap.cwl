cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmap_gsnap
label: gmap_gsnap
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: http://research-pub.gene.com/gmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmap:2025.07.31--pl5321hb1d24b7_1
stdout: gmap_gsnap.out
