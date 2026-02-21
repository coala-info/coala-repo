cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - size
label: seqtk_size
doc: "Calculate the total number of bases and sequences in a FASTA/FASTQ file\n\n
  Tool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file or stream
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_size.out
