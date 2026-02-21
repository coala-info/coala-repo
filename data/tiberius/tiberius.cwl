cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiberius
label: tiberius
doc: "Tiberius is a deep learning-based tool for eukaryotic gene prediction. (Note:
  The provided text contains container build logs rather than CLI help documentation;
  therefore, specific arguments could not be extracted from the input.)\n\nTool homepage:
  https://github.com/Gaius-Augustus/Tiberius"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiberius:1.1.8--pyhdfd78af_0
stdout: tiberius.out
