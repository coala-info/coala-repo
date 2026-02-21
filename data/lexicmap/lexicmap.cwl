cwlVersion: v1.2
class: CommandLineTool
baseCommand: lexicmap
label: lexicmap
doc: "LexicMap is a tool for fast and memory-efficient metagenomic classification.
  (Note: The provided text appears to be a container execution error log rather than
  help text, so no arguments could be extracted.)\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
stdout: lexicmap.out
