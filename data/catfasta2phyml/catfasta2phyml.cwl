cwlVersion: v1.2
class: CommandLineTool
baseCommand: catfasta2phyml
label: catfasta2phyml
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container image build failure (no space
  left on device).\n\nTool homepage: https://github.com/nylander/catfasta2phyml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catfasta2phyml:1.2.1--hdfd78af_0
stdout: catfasta2phyml.out
