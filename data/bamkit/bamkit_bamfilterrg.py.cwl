cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_bamfilterrg.py
label: bamkit_bamfilterrg.py
doc: "A tool from the bamkit suite. (Note: The provided text contains system error
  messages regarding a container build failure and does not include the actual help
  documentation or usage instructions for the tool.)\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamfilterrg.py.out
