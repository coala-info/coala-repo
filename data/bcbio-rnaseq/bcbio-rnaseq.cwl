cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio-rnaseq
label: bcbio-rnaseq
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log indicating a failure to build or extract
  a container image due to insufficient disk space.\n\nTool homepage: https://github.com/hbc/bcbioRNASeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.1_2
stdout: bcbio-rnaseq.out
