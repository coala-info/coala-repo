cwlVersion: v1.2
class: CommandLineTool
baseCommand: edd
label: edd
doc: "The provided text does not contain help information for the tool 'edd'. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to lack of disk space.\n\nTool homepage:
  http://github.com/CollasLab/edd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/edd:1.1.19--py27hc1659b7_0
stdout: edd.out
