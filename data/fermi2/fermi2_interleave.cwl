cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - interleave
label: fermi2_interleave
doc: "Interleave two FASTQ files\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: in1_fq
    type: File
    doc: First input FASTQ file
    inputBinding:
      position: 1
  - id: in2_fq
    type: File
    doc: Second input FASTQ file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_interleave.out
