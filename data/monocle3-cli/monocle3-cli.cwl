cwlVersion: v1.2
class: CommandLineTool
baseCommand: monocle3-cli
label: monocle3-cli
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container environment (Apptainer/Singularity)
  failing to build the image due to lack of disk space.\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
stdout: monocle3-cli.out
