cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomethreader_XML2GFF.py
label: genomethreader_XML2GFF.py
doc: "Converts GenomeThreader XML output to GFF format. (Note: The provided text contains
  system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: http://genomethreader.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomethreader:1.7.1--h503566f_7
stdout: genomethreader_XML2GFF.py.out
