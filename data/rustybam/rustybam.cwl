cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam
label: rustybam
doc: "The provided text is a container execution error log and does not contain help
  information or usage instructions for the tool.\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam.out
