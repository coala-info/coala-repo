cwlVersion: v1.2
class: CommandLineTool
baseCommand: RAMExtend
label: repeatafterme_RAMExtend
doc: "A tool for extending repeat sequences (Note: The provided help text contained
  only container runtime error logs and no usage information).\n\nTool homepage: https://github.com/Dfam-consortium/RepeatAfterMe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatafterme:0.0.7--h7b50bb2_0
stdout: repeatafterme_RAMExtend.out
