cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_bamfixflags.py
label: bamkit_bamfixflags.py
doc: "The provided text does not contain help information for the tool; it contains
  system error logs related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/hall-lab/bamkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamfixflags.py.out
