cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop_add_prefix_to_cool.py
label: neoloop_add_prefix_to_cool.py
doc: "Add a prefix to a .cool file. (Note: The provided help text contained only system
  error messages and no usage information; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop_add_prefix_to_cool.py.out
