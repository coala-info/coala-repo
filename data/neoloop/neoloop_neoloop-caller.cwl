cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop-caller
label: neoloop_neoloop-caller
doc: "Neoloop caller (Note: The provided text is an error log and does not contain
  tool help information or argument definitions)\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop_neoloop-caller.out
