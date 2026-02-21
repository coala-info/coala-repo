cwlVersion: v1.2
class: CommandLineTool
baseCommand: mbuffer
label: mbuffer
doc: "mbuffer is a tool for buffering data streams with a large set of features including
  speed control, progress display, and checksumming.\n\nTool homepage: https://github.com/ilovezfs/mbuffer-osx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbuffer:20160228--h7b50bb2_8
stdout: mbuffer.out
