cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-excel-writer-xlsx
label: perl-excel-writer-xlsx
doc: "The provided text contains system error messages (disk space exhaustion) rather
  than the help documentation for the tool. As a result, no arguments or tool descriptions
  could be extracted.\n\nTool homepage: http://jmcnamara.github.com/excel-writer-xlsx/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-excel-writer-xlsx:1.15--pl5321hdfd78af_0
stdout: perl-excel-writer-xlsx.out
