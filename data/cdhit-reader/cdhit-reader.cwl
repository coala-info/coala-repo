cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdhit-reader
label: cdhit-reader
doc: "A tool for reading CD-HIT output files. (Note: The provided text contains system
  error logs regarding a container build failure and does not include the actual help
  documentation for the tool's arguments.)\n\nTool homepage: https://github.com/telatin/cdhit-parser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdhit-reader:0.2.0--pyhdfd78af_0
stdout: cdhit-reader.out
