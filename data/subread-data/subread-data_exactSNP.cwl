cwlVersion: v1.2
class: CommandLineTool
baseCommand: exactSNP
label: subread-data_exactSNP
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch or build the OCI image.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/subread-data:v1.6.3dfsg-1-deb_cv1
stdout: subread-data_exactSNP.out
