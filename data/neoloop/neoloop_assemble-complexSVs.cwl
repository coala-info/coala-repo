cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop_assemble-complexSVs
label: neoloop_assemble-complexSVs
doc: "Assemble complex structural variants (SVs) using NeoLoop.\n\nTool homepage:
  https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop_assemble-complexSVs.out
