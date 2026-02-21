cwlVersion: v1.2
class: CommandLineTool
baseCommand: jmespath_jp.py
label: jmespath_jp.py
doc: "A JMESPath command-line processor. (Note: The provided text is a system error
  log and does not contain usage instructions or argument definitions.)\n\nTool homepage:
  https://github.com/jmespath/jmespath.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jmespath:0.9.0--py36_0
stdout: jmespath_jp.py.out
