cwlVersion: v1.2
class: CommandLineTool
baseCommand: logol-bin_LogolExec.rb
label: logol-bin_LogolExec.rb
doc: "Logol execution script (Note: The provided help text contains only system error
  messages and no usage information).\n\nTool homepage: https://github.com/genouest/logol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/logol-bin:v1.7.9-1-deb_cv1
stdout: logol-bin_LogolExec.rb.out
