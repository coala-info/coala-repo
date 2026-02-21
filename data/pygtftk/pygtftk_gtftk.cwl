cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtftk
label: pygtftk_gtftk
doc: "GTF toolkit (gtftk) for handling GTF files. (Note: The provided text contains
  system error messages and does not include usage information or argument definitions).\n
  \nTool homepage: http://github.com/dputhier/pygtftk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
stdout: pygtftk_gtftk.out
