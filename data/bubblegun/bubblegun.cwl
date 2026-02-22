cwlVersion: v1.2
class: CommandLineTool
baseCommand: bubblegun
label: bubblegun
doc: "No description available: The provided text is an error log and does not contain
  help information.\n\nTool homepage: https://github.com/fawaz-dabbaghieh/bubble_gun"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bubblegun:1.1.10--pyhdfd78af_0
stdout: bubblegun.out
