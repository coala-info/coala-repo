cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio_compress-fasta
label: dsh-bio_compress-fasta
doc: "Compresses a FASTA file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta
    type: File
    doc: The input FASTA file to compress.
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file for the compressed FASTA. If not specified, the 
      compressed data will be written to standard output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
