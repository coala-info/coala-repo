cwlVersion: v1.2
class: CommandLineTool
baseCommand: genoboo
label: genoboo
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/gogepp/genoboo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genoboo:0.4.18--h9948957_0
stdout: genoboo.out
