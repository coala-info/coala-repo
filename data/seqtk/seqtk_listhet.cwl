cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - listhet
label: seqtk_listhet
doc: "Identify and list heterozygous sites from a sequence file.\n\nTool homepage:
  https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (FASTA/FASTQ)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_listhet.out
