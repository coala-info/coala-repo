cwlVersion: v1.2
class: CommandLineTool
baseCommand: esmre
label: esmre
doc: "The provided text does not contain help information for the tool 'esmre'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/wharris/esmre"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esmre:0.3.1--py27_0
stdout: esmre.out
