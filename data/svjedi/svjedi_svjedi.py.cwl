cwlVersion: v1.2
class: CommandLineTool
baseCommand: svjedi_svjedi.py
label: svjedi_svjedi.py
doc: "Structural variant genotyping tool (Note: The provided text contains only container
  execution logs and error messages, no help documentation was found in the input).\n
  \nTool homepage: https://github.com/llecompte/SVJedi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svjedi:1.1.6--hdfd78af_1
stdout: svjedi_svjedi.py.out
