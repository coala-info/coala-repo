cwlVersion: v1.2
class: CommandLineTool
baseCommand: chexalign
label: chexalign
doc: "The provided text does not contain help documentation or usage instructions;
  it is a log of a failed container build/pull process due to insufficient disk space.\n
  \nTool homepage: https://github.com/seqcode/chexalign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chexalign:0.12--hdfd78af_1
stdout: chexalign.out
