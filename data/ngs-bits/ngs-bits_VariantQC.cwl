cwlVersion: v1.2
class: CommandLineTool
baseCommand: VariantQC
label: ngs-bits_VariantQC
doc: "Calculates QC metrics on variant lists.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: ignore_filter
    type:
      - 'null'
      - boolean
    doc: Ignore filter entries, i.e. consider variants that did not pass 
      filters.
    inputBinding:
      position: 101
      prefix: -ignore_filter
  - id: input_file
    type: File
    doc: Input variant list in VCF format.
    inputBinding:
      position: 101
      prefix: -in
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: Adds LongRead specific QC values (e.g. phasing information)
    inputBinding:
      position: 101
      prefix: -long_read
  - id: phasing_bed_file
    type:
      - 'null'
      - File
    doc: Output BED file containing phasing blocks with id. (requires parameter 
      '-longread')
    inputBinding:
      position: 101
      prefix: -phasing_bed
  - id: settings_file
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
  - id: write_txt
    type:
      - 'null'
      - boolean
    doc: Writes TXT format instead of qcML.
    inputBinding:
      position: 101
      prefix: -txt
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output qcML file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
