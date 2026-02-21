cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgat-scripts-nosetests
label: cgat-scripts-nosetests
doc: "A tool for running nose tests for CGAT scripts. Note: The provided help text
  contains system error logs and does not list specific command-line arguments.\n\n
  Tool homepage: https://www.cgat.org/downloads/public/cgat/documentation/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgat-scripts-nosetests:0.0.4--py27r3.4.1_0
stdout: cgat-scripts-nosetests.out
