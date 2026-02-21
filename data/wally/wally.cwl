cwlVersion: v1.2
class: CommandLineTool
baseCommand: wally
label: wally
doc: "A tool for structural variant visualization and analysis (Note: The provided
  text contains build logs rather than help text, so arguments could not be extracted).\n
  \nTool homepage: https://github.com/tobiasrausch/wally"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wally:0.7.1--h4d20210_1
stdout: wally.out
