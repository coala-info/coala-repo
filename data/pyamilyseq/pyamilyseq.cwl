cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyamilyseq
label: pyamilyseq
doc: "A tool for protein family sequence analysis. (Note: The provided text contains
  container runtime error logs rather than CLI help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/NickJD/PyamilySeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyamilyseq:1.3.2--pyhdfd78af_0
stdout: pyamilyseq.out
