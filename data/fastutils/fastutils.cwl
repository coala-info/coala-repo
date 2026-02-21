cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastutils
label: fastutils
doc: "A utility for processing FASTA/FASTQ files. (Note: The provided text contained
  container runtime error messages rather than tool help text, so no arguments could
  be extracted.)\n\nTool homepage: https://github.com/haghshenas/fastutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastutils:0.3--h077b44d_5
stdout: fastutils.out
