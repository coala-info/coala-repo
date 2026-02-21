cwlVersion: v1.2
class: CommandLineTool
baseCommand: logol-bin_LogolExec.sh
label: logol-bin_LogolExec.sh
doc: "Logol is a pattern matching tool for biological sequences. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list command-line arguments).\n\nTool homepage: https://github.com/genouest/logol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/logol-bin:v1.7.9-1-deb_cv1
stdout: logol-bin_LogolExec.sh.out
