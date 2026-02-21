cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyordereddict
label: cyordereddict
doc: "Cython implementation of Python's collections.OrderedDict\n\nTool homepage:
  https://github.com/shoyer/cyordereddict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyordereddict:0.2.2--py36_0
stdout: cyordereddict.out
