cwlVersion: v1.2
class: CommandLineTool
baseCommand: shellescape
label: shellescape
doc: "A tool to escape strings for shell command lines. (Note: The provided text is
  a container build error log and does not contain usage information or argument definitions.)\n
  \nTool homepage: https://github.com/alessio/shellescape"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shellescape:3.4.1--py35_0
stdout: shellescape.out
