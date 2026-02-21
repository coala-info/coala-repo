cwlVersion: v1.2
class: CommandLineTool
baseCommand: sprai_blastn
label: sprai_blastn
doc: "A tool within the SPRAI (Single Pass Read Accuracy Improver) suite, likely utilizing
  blastn for sequence alignment. Note: The provided text contains container runtime
  error logs rather than help documentation, so no arguments could be extracted.\n
  \nTool homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
stdout: sprai_blastn.out
