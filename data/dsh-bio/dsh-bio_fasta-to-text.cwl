cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dsh-fasta-to-text
label: dsh-bio_fasta-to-text
doc: "convert DNA or protein sequences in FASTA format to tab-separated values (tsv) text format\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta_path
    type: File
    doc: "input FASTA path, default stdin"
    inputBinding:
      position: 101
      prefix: --input-fasta-path
  - id: output_text_file_path
    type: string
    doc: "output text file, default stdout"
    inputBinding:
      position: 101
      prefix: --output-text-file
  - id: alphabet
    type:
      - 'null'
      - string
    doc: "input FASTA alphabet { dna, protein }, default dna"
    inputBinding:
      position: 101
      prefix: --alphabet
outputs:
  - id: output_text_file
    type:
      - 'null'
      - File
    doc: "output text file, default stdout"
    outputBinding:
      glob: $(inputs.output_text_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
