cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phip-stat
  - phip
label: phip-stat_phip
doc: "The provided text contains system logs and error messages related to a container
  build failure rather than the command-line help documentation for phip-stat. As
  a result, no arguments or tool descriptions could be extracted.\n\nTool homepage:
  https://github.com/lasersonlab/phip-stat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phip-stat:0.5.1--pyh7cba7a3_0
stdout: phip-stat_phip.out
