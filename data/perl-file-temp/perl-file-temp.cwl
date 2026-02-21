cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-temp
label: perl-file-temp
doc: "The provided text is a log of a failed container build process and does not
  contain command-line interface help information or arguments for the tool.\n\nTool
  homepage: https://github.com/Taoviqinvicible/Tools-termux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-temp:0.2304--pl526_1
stdout: perl-file-temp.out
