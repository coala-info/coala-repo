cwlVersion: v1.2
class: CommandLineTool
baseCommand: curve-curator
label: curve-curator
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to extract the image due to lack of disk space.\n\nTool homepage: https://github.com/kusterlab/curve_curator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curve-curator:0.6.0--pyhdfd78af_0
stdout: curve-curator.out
