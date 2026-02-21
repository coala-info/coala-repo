cwlVersion: v1.2
class: CommandLineTool
baseCommand: SneakerNet.roRun.pl
label: sneakernet-qc_SneakerNet.roRun.pl
doc: "A tool within the SneakerNet pipeline. Note: The provided help text contains
  only container environment logs and build errors, and does not list specific usage
  instructions or arguments.\n\nTool homepage: https://github.com/lskatz/sneakernet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sneakernet-qc:0.27.2--pl5321hdfd78af_0
stdout: sneakernet-qc_SneakerNet.roRun.pl.out
