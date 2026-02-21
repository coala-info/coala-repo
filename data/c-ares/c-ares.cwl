cwlVersion: v1.2
class: CommandLineTool
baseCommand: c-ares
label: c-ares
doc: "A C library for asynchronous DNS requests (Note: The provided text is an error
  log indicating the executable was not found, rather than help text. No arguments
  could be extracted.)\n\nTool homepage: https://github.com/Cerbersec/Ares"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/c-ares:1.11.0--h470a237_1
stdout: c-ares.out
