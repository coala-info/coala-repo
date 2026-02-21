cwlVersion: v1.2
class: CommandLineTool
baseCommand: mess
label: mess
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/metagenlab/MeSS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mess:0.12.0--pyhdfd78af_0
stdout: mess.out
