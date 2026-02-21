cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanocomp
label: nanocomp
doc: "The provided text is a system error log and does not contain help information
  or argument definitions for the tool 'nanocomp'.\n\nTool homepage: https://github.com/wdecoster/NanoComp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanocomp:1.25.6--pyhdfd78af_0
stdout: nanocomp.out
