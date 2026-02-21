cwlVersion: v1.2
class: CommandLineTool
baseCommand: methcounts
label: methpipe_methcounts
doc: "The provided text is an error message regarding a container environment failure
  and does not contain help documentation for the tool. No arguments could be extracted.\n
  \nTool homepage: https://github.com/smithlabcode/methpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
stdout: methpipe_methcounts.out
