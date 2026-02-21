cwlVersion: v1.2
class: CommandLineTool
baseCommand: irissv
label: irissv
doc: "Iris is a tool for structural variant refinement. (Note: The provided text is
  a system error log and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/mkirsche/Iris"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irissv:1.0.5--hdfd78af_0
stdout: irissv.out
