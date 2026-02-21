cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - randbase
label: seqtk_randbase
doc: "Randomize bases in a sequence file (usually part of the seqtk toolkit)\n\nTool
  homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (FASTA/FASTQ) or stream
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_randbase.out
