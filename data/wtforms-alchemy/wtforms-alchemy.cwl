cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtforms-alchemy
label: wtforms-alchemy
doc: "WTForms-Alchemy is a tool that provides a class for creating WTForms from SQLAlchemy
  models. (Note: The provided text appears to be a container build log rather than
  CLI help text, so no arguments could be extracted.)\n\nTool homepage: https://github.com/kvesteri/wtforms-alchemy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtforms-alchemy:0.16.9--py_0
stdout: wtforms-alchemy.out
