cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartmap
label: smartmap_SmartMapRNAPrep
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container image build failure.\n\nTool
  homepage: http://shah-rohan.github.io/SmartMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartmap:1.0.0--h077b44d_4
stdout: smartmap_SmartMapRNAPrep.out
