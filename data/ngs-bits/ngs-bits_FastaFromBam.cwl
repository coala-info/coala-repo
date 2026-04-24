cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs-bits_FastaFromBam
label: ngs-bits_FastaFromBam
doc: "Download the reference genome FASTA file for a BAM/CRAM file.\n\nTool homepage:
  https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: Input BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: -in
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file. If unset 'reference_genome' from the 
      'settings.ini' file is used.
    inputBinding:
      position: 101
      prefix: -ref
  - id: settings_override_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: tool_definition_xml
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
outputs:
  - id: output_file
    type: File
    doc: Output reference genome FASTA file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
