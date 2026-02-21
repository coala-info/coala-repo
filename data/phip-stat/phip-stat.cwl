cwlVersion: v1.2
class: CommandLineTool
baseCommand: phip-stat
label: phip-stat
doc: "A tool for PhIP-seq (Phage Immunoprecipitation Sequencing) statistical analysis.\n
  \nTool homepage: https://github.com/lasersonlab/phip-stat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phip-stat:0.5.1--pyh7cba7a3_0
stdout: phip-stat.out
