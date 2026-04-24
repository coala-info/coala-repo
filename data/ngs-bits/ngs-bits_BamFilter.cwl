cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamFilter
label: ngs-bits_BamFilter
doc: "Filter alignments in BAM/CRAM file (no input sorting required).\n\nTool homepage:
  https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: Input BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: -in
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum number of gaps (indels) in aligned read, -1 to disable.
    inputBinding:
      position: 101
      prefix: -maxGap
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: Maximum insert size, -1 to disable.
    inputBinding:
      position: 101
      prefix: -maxIS
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches in aligned read, -1 to disable.
    inputBinding:
      position: 101
      prefix: -maxMM
  - id: min_duplicates
    type:
      - 'null'
      - int
    doc: Minimum number of duplicates.
    inputBinding:
      position: 101
      prefix: -minDup
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality.
    inputBinding:
      position: 101
      prefix: -minMQ
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome for CRAM support (mandatory if CRAM is used).
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
  - id: write_cram
    type:
      - 'null'
      - boolean
    doc: Writes a CRAM file as output.
    inputBinding:
      position: 101
      prefix: -write_cram
outputs:
  - id: output_file
    type: File
    doc: Output BAM/CRAM file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
