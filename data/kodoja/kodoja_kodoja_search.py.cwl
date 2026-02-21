cwlVersion: v1.2
class: CommandLineTool
baseCommand: kodoja_kodoja_search.py
label: kodoja_kodoja_search.py
doc: "Kodoja search tool. (Note: The provided help text contains only container runtime
  error messages and does not list usage or arguments.)\n\nTool homepage: https://github.com/abaizan/kodoja/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kodoja:0.0.10--0
stdout: kodoja_kodoja_search.py.out
