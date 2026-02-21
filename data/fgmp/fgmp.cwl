cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgmp
label: fgmp
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/stajichlab/FGMP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgmp:1.0.3--pl526_0
stdout: fgmp.out
