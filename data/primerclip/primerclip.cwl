cwlVersion: v1.2
class: CommandLineTool
baseCommand: primerclip
label: primerclip
doc: "A tool for trimming primer sequences from alignments. (Note: The provided text
  appears to be a container runtime error log rather than the tool's help documentation;
  therefore, no arguments could be extracted from the input.)\n\nTool homepage: https://github.com/swiftbiosciences/primerclip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primerclip:0.3.8--0
stdout: primerclip.out
