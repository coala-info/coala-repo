cwlVersion: v1.2
class: CommandLineTool
baseCommand: sprai
label: sprai
doc: "Single-Pass Read Accuracy Improver (Note: The provided text is a container execution
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
stdout: sprai.out
