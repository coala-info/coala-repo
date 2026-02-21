cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapless_gapless.py
label: gapless_gapless.py
doc: "A tool for closing gaps in genome assemblies. (Note: The provided text contains
  system error messages and does not include usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/schmeing/gapless"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
stdout: gapless_gapless.py.out
