cwlVersion: v1.2
class: CommandLineTool
baseCommand: which
label: perl-file-which_which
doc: "Locate a COMMAND\n\nTool homepage: https://metacpan.org/pod/File::Which"
inputs:
  - id: command
    type:
      - 'null'
      - type: array
        items: string
    doc: The command(s) to locate
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-which:1.23--pl526_0
stdout: perl-file-which_which.out
