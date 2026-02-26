cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbol-converter
label: sbol-utilities_sbol-converter
doc: "Converts genetic design files between various formats.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs:
  - id: input_file_type
    type: string
    doc: 'Input file type, options: FASTA, GenBank, SBOL2, SBOL3 (default)'
    inputBinding:
      position: 1
  - id: output_file_type
    type: string
    doc: 'Output file type, options: FASTA, GenBank, SBOL2, SBOL3 (default)'
    inputBinding:
      position: 2
  - id: input_file
    type: File
    doc: Genetic design file used as input
    inputBinding:
      position: 3
  - id: allow_genbank_online
    type:
      - 'null'
      - boolean
    doc: Perform GenBank conversion using online converter
    inputBinding:
      position: 104
      prefix: --allow-genbank-online
  - id: namespace
    type:
      - 'null'
      - string
    doc: Namespace URL, required for conversions from FASTA and GenBank
    inputBinding:
      position: 104
      prefix: --namespace
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print running explanation of conversion process
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of output file to be written
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
