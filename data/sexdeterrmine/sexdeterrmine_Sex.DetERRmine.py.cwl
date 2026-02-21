cwlVersion: v1.2
class: CommandLineTool
baseCommand: Sex.DetERRmine.py
label: sexdeterrmine_Sex.DetERRmine.py
doc: "A tool for sex determination from sequencing data (Note: The provided text is
  a container build error log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/TCLamnidis/Sex.DetERRmine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sexdeterrmine:1.1.2--hdfd78af_1
stdout: sexdeterrmine_Sex.DetERRmine.py.out
