cwlVersion: v1.2
class: CommandLineTool
baseCommand: sina
label: sina
doc: "SINA (SILVA Incremental Aligner) is a tool for aligning, searching, and classifying
  nucleic acid sequences.\n\nTool homepage: https://github.com/epruesse/SINA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sina:1.7.2--h9aa86b4_0
stdout: sina.out
