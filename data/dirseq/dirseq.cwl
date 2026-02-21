cwlVersion: v1.2
class: CommandLineTool
baseCommand: dirseq
label: dirseq
doc: "A tool for analyzing directional sequencing data (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/wwood/dirseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dirseq:0.4.3--hdfd78af_0
stdout: dirseq.out
