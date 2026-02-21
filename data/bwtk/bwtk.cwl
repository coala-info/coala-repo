cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwtk
label: bwtk
doc: "A command-line toolkit that uses subcommands for processing. (Note: The provided
  help text indicates that '-h' is not a valid flag and suggests using the 'help'
  subcommand for usage information).\n\nTool homepage: https://github.com/bjmt/bwtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
stdout: bwtk.out
