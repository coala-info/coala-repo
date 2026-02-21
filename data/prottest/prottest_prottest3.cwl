cwlVersion: v1.2
class: CommandLineTool
baseCommand: prottest
label: prottest_prottest3
doc: "ProtTest is a bioinformatic tool for the selection of best-fit models of aminoacid
  replacement. (Note: The provided text contained container runtime error messages
  rather than tool help text, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/ddarriba/prottest3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/prottest:v3.4.2dfsg-3-deb_cv1
stdout: prottest_prottest3.out
