cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop_segment-cnv
label: neoloop_segment-cnv
doc: "Segment CNV (Note: The provided text contains container runtime error messages
  and does not include help documentation or argument definitions).\n\nTool homepage:
  https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop_segment-cnv.out
