cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfLeftNormalize
label: ngs-bits_VcfLeftNormalize
doc: "Normalizes all variants and shifts indels to the left in a VCF file. Note: Multi-allelic variants, SNVs, MNPs, complex InDels and invalid variants are skipped!\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Output VCF compression level from 1 (fastest) to 9 (best compression). If unset, an unzipped VCF is written."
    inputBinding:
      position: 1
      prefix: -compression_level
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF or VCF.GZ file. If unset, reads from STDIN."
    inputBinding:
      position: 2
      prefix: -in
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output VCF or VCF or VCF.GZ file. If unset, writes to STDOUT."
    inputBinding:
      position: 3
      prefix: -out
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 4
      prefix: -ref
  - id: right
    type:
      - 'null'
      - boolean
    doc: "Right-normalize VCF instead of left-normalizing it."
    inputBinding:
      position: 5
      prefix: -right
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 6
      prefix: --settings
  - id: stream
    type:
      - 'null'
      - boolean
    doc: "Allows to stream the input and output VCF without loading the whole file into memory. Only supported with uncompressed VCF files."
    inputBinding:
      position: 7
      prefix: -stream
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output VCF or VCF or VCF.GZ file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
