cwlVersion: v1.2
class: CommandLineTool
baseCommand: tetrimmer
label: tetrimmer
doc: "The provided text is a container engine error log and does not contain the help
  documentation or usage instructions for the tool.\n\nTool homepage: https://github.com/qjiangzhao/TETrimmer.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tetrimmer:1.6.2--hdfd78af_0
stdout: tetrimmer.out
