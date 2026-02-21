cwlVersion: v1.2
class: CommandLineTool
baseCommand: sexdeterrmine
label: sexdeterrmine
doc: "A tool for sex determination from sequencing data (Note: The provided help text
  appears to be a container build error log and does not contain usage information).\n
  \nTool homepage: https://github.com/TCLamnidis/Sex.DetERRmine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sexdeterrmine:1.1.2--hdfd78af_1
stdout: sexdeterrmine.out
