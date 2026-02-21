cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - mergepe
label: seqtk_mergepe
doc: "Merge paired-end reads from two separate FASTQ files\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: in1_fq
    type: File
    doc: First input FASTQ file (read 1)
    inputBinding:
      position: 1
  - id: in2_fq
    type: File
    doc: Second input FASTQ file (read 2)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_mergepe.out
