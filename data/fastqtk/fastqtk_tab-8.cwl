cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - tab-8
label: fastqtk_tab-8
doc: "It converts an interleaved paired-end FASTQ file into a tab-delimited text file
  with 8 columns.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: input_fq
    type: File
    doc: Interleaved paired-end FASTQ file. Use - for STDIN.
    inputBinding:
      position: 1
  - id: out_txt
    type: string
    doc: Name of the output file. Tab-delimited text file with 8 columns. Use - for STDOUT.
    inputBinding:
      position: 2
outputs:
  - id: output_fastq_txt
    type: File
    doc: Tab-delimited text file with 8 columns. Use - for STDOUT.
    outputBinding:
      glob: '$(inputs.out_txt)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
