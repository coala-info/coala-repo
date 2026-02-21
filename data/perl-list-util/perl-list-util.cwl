cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-list-util
label: perl-list-util
doc: "The provided text does not contain help documentation or usage instructions.
  It is an error log indicating that the executable 'perl-list-util' was not found
  in the system PATH.\n\nTool homepage: https://github.com/landy22granatt/Kumpulan-Script-Termux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-list-util:1.38--pl526_1
stdout: perl-list-util.out
