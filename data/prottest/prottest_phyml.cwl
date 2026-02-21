cwlVersion: v1.2
class: CommandLineTool
baseCommand: prottest_phyml
label: prottest_phyml
doc: "ProtTest is a tool for selecting the best-fit model of protein evolution. (Note:
  The provided text contains container execution errors rather than help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/ddarriba/prottest3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/prottest:v3.4.2dfsg-3-deb_cv1
stdout: prottest_phyml.out
