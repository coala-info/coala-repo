cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcl2fastq-nextseq
label: bcl2fastq-nextseq
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/brwnj/bcl2fastq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcl2fastq-nextseq:1.3.0--pyh5e36f6f_0
stdout: bcl2fastq-nextseq.out
