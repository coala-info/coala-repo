cwlVersion: v1.2
class: CommandLineTool
baseCommand: probconsrna
label: probconsrna
doc: "Probabilistic Consistency-based Multiple Alignment of RNA Sequences\n\nTool
  homepage: http://probcons.stanford.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probconsrna:1.10--h9f5acd7_4
stdout: probconsrna.out
