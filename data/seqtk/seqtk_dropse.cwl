cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - dropse
label: seqtk_dropse
doc: "Drop single-end reads from interleaved FASTQ\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input interleaved FASTQ file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_dropse.out
