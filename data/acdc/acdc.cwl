cwlVersion: v1.2
class: CommandLineTool
baseCommand: acdc
label: acdc
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/mlux86/acdc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/acdc:1.02--h4ac6f70_0
stdout: acdc.out
