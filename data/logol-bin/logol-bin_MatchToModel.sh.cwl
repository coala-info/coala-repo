cwlVersion: v1.2
class: CommandLineTool
baseCommand: logol-bin_MatchToModel.sh
label: logol-bin_MatchToModel.sh
doc: "The provided text contains execution logs and error messages rather than help
  documentation. No tool description or arguments could be extracted from the input.\n
  \nTool homepage: https://github.com/genouest/logol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/logol-bin:v1.7.9-1-deb_cv1
stdout: logol-bin_MatchToModel.sh.out
