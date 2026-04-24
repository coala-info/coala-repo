cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfSort
label: ngs-bits_VcfSort
doc: "Sorts variant lists according to chromosomal position.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Output VCF compression level from 1 (fastest) to 9 (best compression). 
      If unset, an unzipped VCF is written.
    inputBinding:
      position: 101
      prefix: -compression_level
  - id: fai_file
    type:
      - 'null'
      - File
    doc: FAI file defining different chromosome order.
    inputBinding:
      position: 101
      prefix: -fai
  - id: input_file
    type: File
    doc: Input variant list in VCF format.
    inputBinding:
      position: 101
      prefix: -in
  - id: remove_unused_contigs
    type:
      - 'null'
      - boolean
    doc: Remove comment lines of contigs, i.e. chromosomes, that are not used in
      the output VCF.
    inputBinding:
      position: 101
      prefix: -remove_unused_contigs
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: sort_by_quality
    type:
      - 'null'
      - boolean
    doc: Also sort according to variant quality. Ignored if 'fai' file is given.
    inputBinding:
      position: 101
      prefix: -qual
outputs:
  - id: output_file
    type: File
    doc: Output variant list in VCF or VCF.GZ format.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
