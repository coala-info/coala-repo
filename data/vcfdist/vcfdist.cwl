cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfdist
label: vcfdist
doc: "The provided text does not contain help information for vcfdist; it contains
  container runtime error logs.\n\nTool homepage: https://github.com/TimD1/vcfdist"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfdist:2.6.4--h436c8a6_0
stdout: vcfdist.out
