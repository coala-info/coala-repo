cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnazMAF2BED.pl
label: rnaz_rnazMAF2BED.pl
doc: "A script to convert RNAz results from MAF format to BED format.\n\nTool homepage:
  https://www.tbi.univie.ac.at/~wash/RNAz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8
stdout: rnaz_rnazMAF2BED.pl.out
