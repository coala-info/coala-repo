cwlVersion: v1.2
class: CommandLineTool
baseCommand: funnel_completion
label: funnel_completion
doc: "Generate shell completion code\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: The command to generate completion for (e.g., bash)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel_completion.out
