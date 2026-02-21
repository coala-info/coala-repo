cwlVersion: v1.2
class: CommandLineTool
baseCommand: afragmenter
label: afragmenter
doc: "A tool for fragmenting molecules (description not available in provided text)\n
  \nTool homepage: https://github.com/sverwimp/AFragmenter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afragmenter:0.0.6--pyhdfd78af_0
stdout: afragmenter.out
