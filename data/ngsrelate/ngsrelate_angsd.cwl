cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsrelate
label: ngsrelate_angsd
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/ANGSD/NgsRelate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsrelate:2.0--hea85c65_0
stdout: ngsrelate_angsd.out
