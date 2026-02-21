cwlVersion: v1.2
class: CommandLineTool
baseCommand: woltka
label: woltka
doc: "The provided text does not contain help information or usage instructions for
  the tool 'woltka'. It appears to be a log of a failed container image build or fetch
  process.\n\nTool homepage: https://github.com/qiyunzhu/woltka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
stdout: woltka.out
