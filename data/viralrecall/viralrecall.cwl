cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralrecall
label: viralrecall
doc: "A tool for identifying viral signatures in genomic sequences (Note: The provided
  text contains container runtime error logs rather than the tool's help documentation).\n
  \nTool homepage: https://github.com/abdealijivaji/ViralRecall_3.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralrecall:3.0.2--pyhdfd78af_0
stdout: viralrecall.out
