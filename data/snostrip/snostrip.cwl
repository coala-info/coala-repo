cwlVersion: v1.2
class: CommandLineTool
baseCommand: snostrip
label: snostrip
doc: "The provided text does not contain help information for the tool 'snostrip'.
  It appears to be a log of a failed container image retrieval/build process.\n\n
  Tool homepage: http://snostrip.bioinf.uni-leipzig.de/help.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snostrip:2.0.2--pl5321h503566f_6
stdout: snostrip.out
