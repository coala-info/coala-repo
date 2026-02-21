cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbintk
label: gbintk
doc: "The provided text does not contain help information or usage instructions; it
  consists of container runtime log messages and a fatal error regarding disk space.\n
  \nTool homepage: https://github.com/metagentools/gbintk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbintk:1.0.3--py310h9ee0642_0
stdout: gbintk.out
