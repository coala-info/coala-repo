cwlVersion: v1.2
class: CommandLineTool
baseCommand: axe-demultiplexer
label: axe-demultiplexer
doc: "A tool for demultiplexing FASTQ files (Note: The provided text contains system
  error messages regarding disk space and container execution rather than the tool's
  help documentation. No arguments could be extracted from the input text.)\n\nTool
  homepage: https://github.com/kdmurray91/axe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/axe-demultiplexer:0.3.3--h3a4d415_0
stdout: axe-demultiplexer.out
