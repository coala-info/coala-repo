cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phip-stat
  - kallisto
label: phip-stat_kallisto
doc: "PhIP-seq statistics tool (kallisto subcommand). Note: The provided help text
  contains only system logs and error messages, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/lasersonlab/phip-stat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phip-stat:0.5.1--pyh7cba7a3_0
stdout: phip-stat_kallisto.out
