cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygtftk
label: pygtftk
doc: "A Python toolkit for GTF file manipulation (Note: The provided text was a container
  execution error and did not contain help documentation).\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
stdout: pygtftk.out
