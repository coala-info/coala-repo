cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-spreadsheet-writeexcel
label: perl-spreadsheet-writeexcel
doc: "The executable 'perl-spreadsheet-writeexcel' was not found in the system path,
  and no help text was provided to extract arguments.\n\nTool homepage: https://github.com/pld-linux/perl-Spreadsheet-WriteExcel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-spreadsheet-writeexcel:2.40--pl526_1
stdout: perl-spreadsheet-writeexcel.out
