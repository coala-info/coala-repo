cwlVersion: v1.2
class: CommandLineTool
baseCommand: vipe
label: moreutils_vipe
doc: "vipe (visual pipe) allows you to run your editor in the middle of a pipe which
  receives the input from the pipe, and the output of the editor is sent to the next
  command in the pipe.\n\nTool homepage: https://github.com/madx/moreutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_vipe.out
