cwlVersion: v1.2
class: CommandLineTool
baseCommand: necat_necat.pl
label: necat_necat.pl
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  due to insufficient disk space.\n\nTool homepage: https://github.com/xiaochuanle/NECAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
stdout: necat_necat.pl.out
