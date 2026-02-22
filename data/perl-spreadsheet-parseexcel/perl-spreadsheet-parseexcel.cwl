cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-spreadsheet-parseexcel
label: perl-spreadsheet-parseexcel
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) and does not contain the help text or usage information
  for the tool itself.\n\nTool homepage: http://github.com/runrig/spreadsheet-parseexcel/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-spreadsheet-parseexcel:0.66--pl5321hdfd78af_0
stdout: perl-spreadsheet-parseexcel.out
