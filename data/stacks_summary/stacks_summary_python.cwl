cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks_summary_python
label: stacks_summary_python
doc: "The provided text contains environment logs and a fatal error regarding container
  image retrieval rather than the tool's help documentation. As a result, no arguments
  or functional descriptions could be extracted.\n\nTool homepage: https://github.com/Jayrajsinh-Gohil/ResearchGPT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_summary_python.out
