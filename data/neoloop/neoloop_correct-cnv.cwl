cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - neoloop
  - correct-cnv
label: neoloop_correct-cnv
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding a lack of disk space during image conversion.\n
  \nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop_correct-cnv.out
