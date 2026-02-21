cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq-build
label: krakenuniq_krakenuniq-build
doc: "Build a KrakenUniq database (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/fbreitwieser/krakenuniq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
stdout: krakenuniq_krakenuniq-build.out
