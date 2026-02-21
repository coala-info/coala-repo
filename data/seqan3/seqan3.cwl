cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqan3
label: seqan3
doc: "The provided text does not contain help information or usage instructions. It
  is a log of a failed container image build/extraction process due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://www.seqan.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqan3:3.4.0--haf24da9_0
stdout: seqan3.out
