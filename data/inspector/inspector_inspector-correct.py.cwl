cwlVersion: v1.2
class: CommandLineTool
baseCommand: inspector-correct.py
label: inspector_inspector-correct.py
doc: "A tool for error correction in genomic assemblies (Note: The provided help text
  contains only system error logs and no usage information. Arguments could not be
  extracted from the provided text.)\n\nTool homepage: https://github.com/ChongLab/Inspector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/inspector:1.3.1--hdfd78af_1
stdout: inspector_inspector-correct.py.out
