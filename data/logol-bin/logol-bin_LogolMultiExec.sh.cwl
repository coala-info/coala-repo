cwlVersion: v1.2
class: CommandLineTool
baseCommand: logol-bin_LogolMultiExec.sh
label: logol-bin_LogolMultiExec.sh
doc: "A script for multi-execution of Logol. Note: The provided help text contains
  only container runtime error messages and does not list usage instructions or arguments.\n
  \nTool homepage: https://github.com/genouest/logol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/logol-bin:v1.7.9-1-deb_cv1
stdout: logol-bin_LogolMultiExec.sh.out
