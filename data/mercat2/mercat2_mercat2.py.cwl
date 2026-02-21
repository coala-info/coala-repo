cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat2_mercat2.py
label: mercat2_mercat2.py
doc: "mercat2_mercat2.py (Note: The provided help text contains only system error
  messages and no usage information or arguments.)\n\nTool homepage: https://github.com/raw-lab/mercat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat2:1.4.1--pyhdfd78af_0
stdout: mercat2_mercat2.py.out
