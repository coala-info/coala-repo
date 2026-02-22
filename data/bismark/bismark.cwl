cwlVersion: v1.2
class: CommandLineTool
baseCommand: bismark
label: bismark
doc: "A tool to map bisulfite converted sequence reads and determine cytosine methylation
  states. (Note: The provided input text contained system error messages regarding
  disk space and container conversion rather than the tool's help documentation.)\n\
  \nTool homepage: https://github.com/FelixKrueger/Bismark/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bismark:0.25.1--hdfd78af_0
stdout: bismark.out
