cwlVersion: v1.2
class: CommandLineTool
baseCommand: ig-flowtools
label: ig-flowtools
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages and a fatal error regarding container image acquisition
  (no space left on device).\n\nTool homepage: https://github.com/ImmPortDB/ig-flowtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ig-flowtools:2.0.2--py27r341h24bf2e0_1
stdout: ig-flowtools.out
