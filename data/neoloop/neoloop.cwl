cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop
label: neoloop
doc: "A tool for identifying neoantigens and looping structures (Note: The provided
  text contains error logs rather than help documentation, so specific arguments could
  not be parsed).\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop.out
