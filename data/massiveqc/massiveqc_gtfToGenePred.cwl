cwlVersion: v1.2
class: CommandLineTool
baseCommand: massiveqc_gtfToGenePred
label: massiveqc_gtfToGenePred
doc: "The provided text does not contain help information for the tool, as it consists
  of container runtime error messages (Apptainer/Singularity) regarding insufficient
  disk space.\n\nTool homepage: https://github.com/shimw6828/MassiveQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
stdout: massiveqc_gtfToGenePred.out
