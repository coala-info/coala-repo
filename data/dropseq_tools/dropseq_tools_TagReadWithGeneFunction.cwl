cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - TagReadWithGeneFunction
label: dropseq_tools_TagReadWithGeneFunction
doc: "The provided text contains system error messages related to a container runtime
  failure (no space left on device) and does not contain the help documentation for
  the tool. As a result, no arguments could be extracted.\n\nTool homepage: http://mccarrolllab.com/dropseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
stdout: dropseq_tools_TagReadWithGeneFunction.out
