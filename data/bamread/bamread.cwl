cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamread
label: bamread
doc: "The provided text does not contain help information or usage instructions for
  the tool 'bamread'. It appears to be a system error log related to a container build
  failure (no space left on device).\n\nTool homepage: http://github.com/endrebak/bamread"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamread:0.0.20--py310h1fe012e_1
stdout: bamread.out
