cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kid
  - kids
label: kid_kids
doc: "Kid is a simple template language for XML-based vocabularies written in Python.\n
  \nTool homepage: https://github.com/zhihu/kids"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kid:0.9.6--py27_1
stdout: kid_kids.out
