cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgatk
  - threeframe-translation
label: pypgatk_threeframe-translation
doc: "Command to perform 3'frame translation\n\nTool homepage:
  http://github.com/bigbio/py-pgatk"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration to perform conversion between ENSEMBL Files
    inputBinding:
      position: 101
      prefix: --config_file
  - id: input_fasta
    type: File
    doc: input_fasta file to perform the translation
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Translation table default value 1
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: output_path
    type: string
    doc: Output File
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output File
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
