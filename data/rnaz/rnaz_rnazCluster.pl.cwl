cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnazCluster.pl
label: rnaz_rnazCluster.pl
doc: "The provided text contains container runtime errors and does not include the
  help documentation or usage instructions for rnazCluster.pl.\n\nTool homepage: https://www.tbi.univie.ac.at/~wash/RNAz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8
stdout: rnaz_rnazCluster.pl.out
