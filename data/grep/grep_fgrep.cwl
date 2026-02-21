cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgrep
label: grep_fgrep
doc: "Search for fixed-string patterns in files. (Note: The provided text appears
  to be a system error log rather than help text, so no arguments could be extracted.)\n
  \nTool homepage: https://www.gnu.org/software/grep/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ubuntu:latest
stdout: grep_fgrep.out
