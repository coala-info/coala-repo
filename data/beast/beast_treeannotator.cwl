cwlVersion: v1.2
class: CommandLineTool
baseCommand: treeannotator
label: beast_treeannotator
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a container image
  due to lack of disk space ('no space left on device').\n\nTool homepage: https://beast.community"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beast:10.5.0--hdfd78af_0
stdout: beast_treeannotator.out
