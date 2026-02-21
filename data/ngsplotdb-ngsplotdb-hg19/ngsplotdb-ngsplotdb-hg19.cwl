cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsplotdb-ngsplotdb-hg19
label: ngsplotdb-ngsplotdb-hg19
doc: "A database package for ngsplot containing hg19 genome data. Note: The provided
  text contains system error logs regarding container image retrieval and does not
  list specific command-line arguments.\n\nTool homepage: https://github.com/shenlab-sinai/ngsplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
stdout: ngsplotdb-ngsplotdb-hg19.out
