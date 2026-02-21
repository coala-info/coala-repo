cwlVersion: v1.2
class: CommandLineTool
baseCommand: discasm
label: discasm
doc: "A tool for discovery of sequences from assembly. (Note: The provided help text
  contains container runtime error messages and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/DISCASM/DISCASM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/discasm:0.1.3--py27pl5.22.0_0
stdout: discasm.out
