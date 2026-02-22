cwlVersion: v1.2
class: CommandLineTool
baseCommand: velvet-example
label: velvet-example
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the tool.\n\nTool homepage: https://github.com/velvet-revolver/example"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/velvet-example:v1.2.10dfsg1-5-deb_cv1
stdout: velvet-example.out
