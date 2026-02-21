cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssuissero_SsuisSero.sh
label: ssuissero_SsuisSero.sh
doc: "A tool for serotyping Streptococcus suis (inferred from tool name and container
  image). Note: The provided text contains execution logs and error messages rather
  than command-line help documentation, so no arguments could be extracted.\n\nTool
  homepage: https://github.com/jimmyliu1326/SsuisSero"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssuissero:1.0.1--hdfd78af_1
stdout: ssuissero_SsuisSero.sh.out
