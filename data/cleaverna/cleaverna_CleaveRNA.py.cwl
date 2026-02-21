cwlVersion: v1.2
class: CommandLineTool
baseCommand: cleaverna_CleaveRNA.py
label: cleaverna_CleaveRNA.py
doc: "CleaveRNA tool (Note: The provided help text contains only system error messages
  regarding a container build failure and does not list usage instructions or arguments).\n
  \nTool homepage: https://github.com/reyhaneh-tavakoli/CleaveRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleaverna:1.0.0--pyhdfd78af_0
stdout: cleaverna_CleaveRNA.py.out
