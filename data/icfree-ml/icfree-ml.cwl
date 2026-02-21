cwlVersion: v1.2
class: CommandLineTool
baseCommand: icfree-ml
label: icfree-ml
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/brsynth/icfree-ml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/icfree-ml:2.9.1--pyhdfd78af_0
stdout: icfree-ml.out
