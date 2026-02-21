cwlVersion: v1.2
class: CommandLineTool
baseCommand: hpsuissero_HpsuisSero.sh
label: hpsuissero_HpsuisSero.sh
doc: "A tool for serotyping Haemophilus parasuis. (Note: The provided help text contains
  only system error messages regarding container execution and does not list command-line
  arguments).\n\nTool homepage: https://github.com/jimmyliu1326/HpsuisSero"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hpsuissero:1.0.1--hdfd78af_0
stdout: hpsuissero_HpsuisSero.sh.out
