cwlVersion: v1.2
class: CommandLineTool
baseCommand: cligv
label: cligv
doc: "Command-line tool cligv (Help text provided contains only system error logs
  and no usage information).\n\nTool homepage: https://github.com/jonasfreudig/cligv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cligv:0.1.0--pyhdfd78af_0
stdout: cligv.out
