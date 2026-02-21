cwlVersion: v1.2
class: CommandLineTool
baseCommand: transrate
label: transrate
doc: "The provided text is an error log from a container build process and does not
  contain the tool's help text. Based on the tool name 'transrate', it is a software
  for de novo transcriptome assembly evaluation.\n\nTool homepage: https://github.com/blahah/transrate/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transrate:1.0.3--h516909a_0
stdout: transrate.out
