cwlVersion: v1.2
class: CommandLineTool
baseCommand: vitap
label: vitap
doc: "The provided text does not contain help information or argument definitions;
  it is a log of a failed container build/fetch process for the vitap tool.\n\nTool
  homepage: https://github.com/DrKaiyangZheng/VITAP/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vitap:1.10--pyhdfd78af_0
stdout: vitap.out
