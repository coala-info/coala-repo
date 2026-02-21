cwlVersion: v1.2
class: CommandLineTool
baseCommand: subread_exactSNP
label: subread_exactSNP
doc: "The provided text does not contain help information for subread_exactSNP. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch or build the container image.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
stdout: subread_exactSNP.out
