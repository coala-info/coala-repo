cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - lengths
label: fastqtk_lengths
doc: "It provides a summary statistics regarding the lengths of the reads from an
  input FASTQ file and outputs it to a text file. The output text file contains the
  unique lengths of the reads found in the input file, which are sorted in descending
  order.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: input_fq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: out_txt
    type: string
    doc: Name of the output file. Output text file
    inputBinding:
      position: 2
outputs:
  - id: output_txt
    type: File
    doc: Output text file
    outputBinding:
      glob: '$(inputs.out_txt)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
