cwlVersion: v1.2
class: CommandLineTool
baseCommand: whokaryote
label: whokaryote
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build or execution attempt.\n\nTool homepage:
  https://github.com/LottePronk/whokaryote"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whokaryote:1.1.2--pyhdfd78af_0
stdout: whokaryote.out
