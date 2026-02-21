cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks_summary
label: stacks_summary
doc: "A component of the Stacks software suite. Note: The provided text contains system
  error logs rather than help documentation, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/Jayrajsinh-Gohil/ResearchGPT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_summary.out
