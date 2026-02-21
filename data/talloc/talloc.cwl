cwlVersion: v1.2
class: CommandLineTool
baseCommand: talloc
label: talloc
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build or execution attempt.\n
  \nTool homepage: https://github.com/esneider/talloc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talloc:2.1.9--0
stdout: talloc.out
