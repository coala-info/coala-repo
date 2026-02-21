cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-grep
label: perl-file-grep
doc: "The tool 'perl-file-grep' could not be executed, and no help text was provided
  in the input. The output indicates a fatal error where the executable was not found
  in the system PATH.\n\nTool homepage: https://www.gnu.org/software/grep/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-grep:0.02--pl526_2
stdout: perl-file-grep.out
