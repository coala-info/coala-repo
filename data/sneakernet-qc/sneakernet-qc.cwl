cwlVersion: v1.2
class: CommandLineTool
baseCommand: sneakernet-qc
label: sneakernet-qc
doc: "A quality control tool for the SneakerNet pipeline. Note: The provided text
  contains container build logs rather than CLI help documentation, so specific arguments
  could not be extracted.\n\nTool homepage: https://github.com/lskatz/sneakernet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sneakernet-qc:0.27.2--pl5321hdfd78af_0
stdout: sneakernet-qc.out
