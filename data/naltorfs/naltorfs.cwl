cwlVersion: v1.2
class: CommandLineTool
baseCommand: naltorfs
label: naltorfs
doc: "The provided text does not contain help information for naltorfs; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/BlankenbergLab/nAltORFs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naltorfs:0.1.2
stdout: naltorfs.out
