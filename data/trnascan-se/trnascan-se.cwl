cwlVersion: v1.2
class: CommandLineTool
baseCommand: trnascan-se
label: trnascan-se
doc: "The provided text does not contain help information for trnascan-se; it is an
  error log indicating a failure to build or extract the container image due to lack
  of disk space.\n\nTool homepage: http://lowelab.ucsc.edu/tRNAscan-SE/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trnascan-se:2.0.12--pl5321h7b50bb2_2
stdout: trnascan-se.out
