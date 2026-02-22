cwlVersion: v1.2
class: CommandLineTool
baseCommand: coral
label: coral
doc: "The provided text is a runtime error log from a container build/execution process
  and does not contain help text or usage information. Consequently, no arguments
  could be extracted.\n\nTool homepage: https://github.com/Shao-Group/coral"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coral:1.0.0--hf5e1fbb_1
stdout: coral.out
