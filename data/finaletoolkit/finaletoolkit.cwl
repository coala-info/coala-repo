cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit
label: finaletoolkit
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
stdout: finaletoolkit.out
