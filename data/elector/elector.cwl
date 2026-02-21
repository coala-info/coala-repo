cwlVersion: v1.2
class: CommandLineTool
baseCommand: elector
label: elector
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/kamimrcht/ELECTOR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elector:1.0.4--py312h719dbc0_5
stdout: elector.out
