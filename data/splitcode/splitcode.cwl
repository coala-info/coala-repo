cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitcode
label: splitcode
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/pachterlab/splitcode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splitcode:0.31.6--h077b44d_0
stdout: splitcode.out
