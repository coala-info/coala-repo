cwlVersion: v1.2
class: CommandLineTool
baseCommand: carna
label: carna
doc: "CARNA is a tool for ensemble-based alignment of RNA structures. (Note: The provided
  input text appears to be a container execution error log rather than help text,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/Code52/carnac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carna:1.3.3--1
stdout: carna.out
