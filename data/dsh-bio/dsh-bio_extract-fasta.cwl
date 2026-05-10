cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio_extract-fasta
label: dsh-bio_extract-fasta
doc: "Extracts sequences from a FASTA file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta
    type: File
    doc: The input FASTA file.
    inputBinding:
      position: 1
  - id: sequence_names
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of sequence names to extract. If not provided, all sequences 
      will be extracted.
    inputBinding:
      position: 2
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file to write the extracted sequences to. If not provided, 
      sequences will be written to standard output.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
