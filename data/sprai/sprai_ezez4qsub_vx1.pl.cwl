cwlVersion: v1.2
class: CommandLineTool
baseCommand: sprai_ezez4qsub_vx1.pl
label: sprai_ezez4qsub_vx1.pl
doc: "The provided text is a container runtime error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
stdout: sprai_ezez4qsub_vx1.pl.out
