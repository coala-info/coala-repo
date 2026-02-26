cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - fq-sum
label: fuc_fq-sum
doc: "Summarize a FASTQ file.\n\nThis command will output a summary of the input FASTQ
  file. The summary\nincludes the total number of sequence reads, the distribution
  of read\nlengths, and the numbers of unique and duplicate sequences.\n\nTool homepage:
  https://github.com/sbslee/fuc"
inputs:
  - id: fastq
    type: File
    doc: Input FASTQ file (compressed or uncompressed).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fq-sum.out
