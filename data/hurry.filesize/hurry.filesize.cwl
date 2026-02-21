cwlVersion: v1.2
class: CommandLineTool
baseCommand: hurry.filesize
label: hurry.filesize
doc: "A tool for formatting file sizes (Note: The provided text is an error log from
  a container runtime and does not contain the tool's help documentation or usage
  instructions).\n\nTool homepage: https://github.com/pld-linux/python-hurry.filesize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hurry.filesize:0.9--py35_0
stdout: hurry.filesize.out
