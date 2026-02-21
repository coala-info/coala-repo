cwlVersion: v1.2
class: CommandLineTool
baseCommand: phizz
label: phizz
doc: "Phizz is a tool for prioritizing human phenotypes. (Note: The provided text
  appears to be a container runtime error log rather than help text, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/moonso/phizz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phizz:0.2.3--py_0
stdout: phizz.out
