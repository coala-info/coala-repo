cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepacvir
label: deepacvir
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Singularity/Apptainer) failing to build
  an image due to insufficient disk space.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacvir:0.2.2--py_0
stdout: deepacvir.out
