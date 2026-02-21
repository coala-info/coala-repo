cwlVersion: v1.2
class: CommandLineTool
baseCommand: demultiplexer2
label: demultiplexer2
doc: "A tool for demultiplexing. (Note: The provided text is a container execution
  error log and does not contain usage instructions or argument definitions).\n\n
  Tool homepage: https://github.com/DominikBuchner/demultiplexer2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0
stdout: demultiplexer2.out
