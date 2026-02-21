cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk
label: gtdbtk
doc: "GTDB-Tk is a software toolkit for assigning objective taxonomic classifications
  to bacterial and archaeal genomes.\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
stdout: gtdbtk.out
