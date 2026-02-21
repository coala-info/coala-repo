cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngslca
label: ngslca
doc: "The provided text does not contain help information for ngslca; it is an error
  log indicating a failure to build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/miwipe/ngsLCA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngslca:1.0.5--h13024bc_4
stdout: ngslca.out
