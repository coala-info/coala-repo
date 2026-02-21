cwlVersion: v1.2
class: CommandLineTool
baseCommand: shellescape
label: shellescape_escargs
doc: "The provided text does not contain help information for the tool, but appears
  to be an error log from a container build process. Based on the tool name, this
  utility is likely used for escaping shell arguments.\n\nTool homepage: https://github.com/alessio/shellescape"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shellescape:3.4.1--py35_0
stdout: shellescape_escargs.out
