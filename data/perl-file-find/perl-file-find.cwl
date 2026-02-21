cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-find
label: perl-file-find
doc: "The provided text is an error log indicating that the executable 'perl-file-find'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://github.com/landy22granatt/Kumpulan-Script-Termux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-find:1.27--pl5.22.0_0
stdout: perl-file-find.out
