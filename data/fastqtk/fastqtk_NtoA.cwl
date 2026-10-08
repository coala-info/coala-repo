cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - NtoA
label: fastqtk_NtoA
doc: "It replaces all the As from reads sequences with As in a FASTQ file.\n\nTool
  homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: input_fq
    type: File
    doc: Input FASTQ file. Use - for STDIN.
    inputBinding:
      position: 1
  - id: out_fq
    type: string
    doc: Name of the output file. Output FASTQ file. Use - for STDOUT.
    inputBinding:
      position: 2
outputs:
  - id: output_fq
    type: File
    doc: Output FASTQ file. Use - for STDOUT.
    outputBinding:
      glob: '$(inputs.out_fq)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
