cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymlst
label: pymlst
doc: "A tool for Multi-Locus Sequence Typing (MLST). Note: The provided text appears
  to be a container build log rather than help text, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/bvalot/pyMLST.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst.out
