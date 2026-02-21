cwlVersion: v1.2
class: CommandLineTool
baseCommand: sprai_runCA
label: sprai_runCA
doc: "A tool within the SPRAI (Single-Pass Read Accuracy Improvement) pipeline, likely
  used for running the Celera Assembler.\n\nTool homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
stdout: sprai_runCA.out
