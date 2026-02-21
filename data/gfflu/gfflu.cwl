cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfflu
label: gfflu
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/CFIA-NCFAD/gfflu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfflu:0.0.2--pyhdfd78af_0
stdout: gfflu.out
