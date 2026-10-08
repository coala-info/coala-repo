cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_clipping_histogram.pl
label: fastx_toolkit_fasta_clipping_histogram
doc: "Create a Linker Clipping Information Histogram from a FASTA file (can be GZIPped).\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: input_fasta
    type: File
    doc: "Input file in FASTA format (can be GZIPped)."
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: "Output histogram image file name (PNG)."
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Histogram image (PNG)."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
