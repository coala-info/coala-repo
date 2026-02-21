cwlVersion: v1.2
class: CommandLineTool
baseCommand: learnmsa
label: learnmsa
doc: "Multiple Sequence Alignment using machine learning. (Note: The provided text
  is a container execution error log and does not contain the tool's help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/Gaius-Augustus/learnMSA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/learnmsa:2.0.16--pyhdfd78af_0
stdout: learnmsa.out
