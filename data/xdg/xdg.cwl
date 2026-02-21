cwlVersion: v1.2
class: CommandLineTool
baseCommand: xdg
label: xdg
doc: "The provided text appears to be a log of a failed container build or image fetch
  process rather than command-line help text. No arguments or usage information could
  be extracted from the input.\n\nTool homepage: https://github.com/srstevenson/xdg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xdg:1.0.5--py35_0
stdout: xdg.out
