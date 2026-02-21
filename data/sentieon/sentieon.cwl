cwlVersion: v1.2
class: CommandLineTool
baseCommand: sentieon
label: sentieon
doc: "Sentieon genomics tools (Note: The provided text is a container runtime error
  log and does not contain help documentation or usage instructions).\n\nTool homepage:
  https://github.com/Sentieon/sentieon-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sentieon:202503.02--h5ca1c30_0
stdout: sentieon.out
