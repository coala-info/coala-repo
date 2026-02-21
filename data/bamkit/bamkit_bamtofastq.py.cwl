cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_bamtofastq.py
label: bamkit_bamtofastq.py
doc: "A tool from the bamkit suite (Note: The provided text is a system error log
  regarding a failed container build and does not contain the tool's help documentation
  or argument definitions).\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamtofastq.py.out
