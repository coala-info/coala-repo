cwlVersion: v1.2
class: CommandLineTool
baseCommand: gpatch_GPatch.py
label: gpatch_GPatch.py
doc: "GPatch is a tool for patching genomic assemblies. (Note: The provided help text
  contains only system error messages regarding container execution and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/adadiehl/GPatch.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gpatch:0.4.0--pyhdfd78af_0
stdout: gpatch_GPatch.py.out
