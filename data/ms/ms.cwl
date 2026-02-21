cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms
label: ms
doc: "A tool for generating samples under a variety of neutral models (coalescent
  simulator). Note: The provided help text contains only system error messages regarding
  container execution and does not list command-line arguments.\n\nTool homepage:
  https://github.com/LC044/WeChatMsg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms:2014_03_04--0
stdout: ms.out
