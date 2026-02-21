cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop_calculate-cnv
label: neoloop_calculate-cnv
doc: "The provided text is an error message regarding a container runtime failure
  and does not contain help documentation or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop_calculate-cnv.out
