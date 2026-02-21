cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccne
label: ccne
doc: "The provided text does not contain help information for the tool 'ccne'. It
  is an error log indicating a failure to build a container image from 'docker://quay.io/biocontainers/ccne:1.1.2--hdfd78af_0'
  due to insufficient disk space.\n\nTool homepage: https://github.com/biojiang/ccne"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccne:1.1.2--hdfd78af_0
stdout: ccne.out
