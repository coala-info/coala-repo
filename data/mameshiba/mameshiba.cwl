cwlVersion: v1.2
class: CommandLineTool
baseCommand: mameshiba
label: mameshiba
doc: "A tool for metagenomic analysis (Note: The provided input text contains container
  runtime error logs rather than the tool's help documentation).\n\nTool homepage:
  https://github.com/Sika-Zheng-Lab/Shiba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mameshiba:0.8.1--hdfd78af_0
stdout: mameshiba.out
