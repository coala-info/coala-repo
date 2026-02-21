cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viral-ngs
  - muscle
label: viral-ngs_MUSCLE
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime log messages and a fatal error regarding
  an image build failure.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_MUSCLE.out
