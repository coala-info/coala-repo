cwlVersion: v1.2
class: CommandLineTool
baseCommand: subjunc
label: subread_subjunc
doc: "The provided text does not contain help information or usage instructions for
  subread_subjunc. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to fetch the OCI image.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
stdout: subread_subjunc.out
