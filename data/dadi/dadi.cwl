cwlVersion: v1.2
class: CommandLineTool
baseCommand: dadi
label: dadi
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://bitbucket.org/gutenkunstlab/dadi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dadi:2.0.5--py36hc1659b7_0
stdout: dadi.out
