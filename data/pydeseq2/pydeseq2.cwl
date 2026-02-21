cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydeseq2
label: pydeseq2
doc: "A python implementation of the DESeq2 method for differential expression analysis.\n
  \nTool homepage: https://github.com/owkin/PyDESeq2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydeseq2:0.5.4--pyhdfd78af_0
stdout: pydeseq2.out
