cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaz_rnazOutputSort.pl
label: rnaz_rnazOutputSort.pl
doc: "A script to sort RNAz output. (Note: The provided help text contains only container
  execution errors and does not list specific arguments.)\n\nTool homepage: https://www.tbi.univie.ac.at/~wash/RNAz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8
stdout: rnaz_rnazOutputSort.pl.out
