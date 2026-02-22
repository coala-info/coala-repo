cwlVersion: v1.2
class: CommandLineTool
baseCommand: phynteny
label: phynteny
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a failed Singularity/Docker container
  execution due to insufficient disk space.\n\nTool homepage: https://github.com/susiegriggo/Phynteny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phynteny:0.1.13--pyh7cba7a3_0
stdout: phynteny.out
