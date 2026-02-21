cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask-markdown
label: flask-markdown
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed execution attempt where the executable was not found.\n
  \nTool homepage: https://github.com/cirosantilli/china-dictatorship"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-markdown:0.3--py36_0
stdout: flask-markdown.out
