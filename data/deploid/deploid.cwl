cwlVersion: v1.2
class: CommandLineTool
baseCommand: deploid
label: deploid
doc: "A tool for deconvolving polyploid genomes. (Note: The provided text is a system
  error log from a container runtime and does not contain usage instructions or argument
  definitions.)\n\nTool homepage: http://deploid.readthedocs.io/en/latest/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deploid:v0.5--h1341992_1
stdout: deploid.out
