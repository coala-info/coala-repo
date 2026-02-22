cwlVersion: v1.2
class: CommandLineTool
baseCommand: phynteny_transformer
label: phynteny_transformer
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to lack of disk space.\n\nTool homepage: https://github.com/susiegriggo/Phynteny_transformer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phynteny:0.1.13--pyh7cba7a3_0
stdout: phynteny_transformer.out
