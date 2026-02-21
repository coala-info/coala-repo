cwlVersion: v1.2
class: CommandLineTool
baseCommand: lace
label: lace
doc: "The provided text is an error log indicating a failure to build or run the Lace
  container due to insufficient disk space, rather than help text. No command-line
  arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/Oshlack/Lace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lace:1.14.1--pyh5e36f6f_0
stdout: lace.out
