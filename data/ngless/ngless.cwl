cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngless
label: ngless
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  acquisition.\n\nTool homepage: http://ngless.embl.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngless:1.5.0--h9ee0642_0
stdout: ngless.out
