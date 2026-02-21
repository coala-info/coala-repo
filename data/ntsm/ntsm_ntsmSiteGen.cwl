cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntsmSiteGen
label: ntsm_ntsmSiteGen
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failure due to
  insufficient disk space.\n\nTool homepage: https://github.com/JustinChu/ntsm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
stdout: ntsm_ntsmSiteGen.out
