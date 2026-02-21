cwlVersion: v1.2
class: CommandLineTool
baseCommand: sprai_ezez_vx1.pl
label: sprai_ezez_vx1.pl
doc: "A tool for single-pass read accuracy improvement (SPRAI). Note: The provided
  help text contains container execution errors and does not list specific command-line
  arguments.\n\nTool homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
stdout: sprai_ezez_vx1.pl.out
