cwlVersion: v1.2
class: CommandLineTool
baseCommand: wade_SerotypeR
label: wade_SerotypeR
doc: "The provided text does not contain help documentation for the tool. It consists
  of system logs and a fatal error message regarding a container build failure.\n\n
  Tool homepage: https://github.com/phac-nml/wade"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wade:1.2.0--r44hdfd78af_0
stdout: wade_SerotypeR.out
