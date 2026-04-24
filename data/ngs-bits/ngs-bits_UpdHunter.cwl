cwlVersion: v1.2
class: CommandLineTool
baseCommand: UpdHunter
label: ngs-bits_UpdHunter
doc: "UPD detection from trio variant data.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: child_header
    type: string
    doc: Header name of child.
    inputBinding:
      position: 101
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable verbose debug output.
    inputBinding:
      position: 101
      prefix: -debug
  - id: exclude_bed
    type:
      - 'null'
      - File
    doc: BED file with regions to exclude, e.g. copy-number variant regions.
    inputBinding:
      position: 101
      prefix: -exclude
  - id: ext_marker_perc
    type:
      - 'null'
      - float
    doc: Percentage of markers that can be spanned when merging adjacent regions
      .
    inputBinding:
      position: 101
      prefix: -ext_marker_perc
  - id: ext_size_perc
    type:
      - 'null'
      - float
    doc: Percentage of base size that can be spanned when merging adjacent 
      regions.
    inputBinding:
      position: 101
      prefix: -ext_size_perc
  - id: father_header
    type: string
    doc: Header name of father.
    inputBinding:
      position: 101
      prefix: -f
  - id: input_vcf
    type: File
    doc: Input VCF file of trio.
    inputBinding:
      position: 101
      prefix: -in
  - id: mother_header
    type: string
    doc: Header name of mother.
    inputBinding:
      position: 101
      prefix: -m
  - id: reg_min_kb
    type:
      - 'null'
      - float
    doc: Mimimum size in kilo-bases required for a UPD region.
    inputBinding:
      position: 101
      prefix: -reg_min_kb
  - id: reg_min_markers
    type:
      - 'null'
      - int
    doc: Mimimum number of UPD markers required in a region.
    inputBinding:
      position: 101
      prefix: -reg_min_markers
  - id: reg_min_q
    type:
      - 'null'
      - float
    doc: Mimimum Q-score required for a UPD region.
    inputBinding:
      position: 101
      prefix: -reg_min_q
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: tdx
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
  - id: use_indels
    type:
      - 'null'
      - boolean
    doc: Also use InDels. The default is to use SNVs only.
    inputBinding:
      position: 101
      prefix: -var_use_indels
  - id: var_min_dp
    type:
      - 'null'
      - int
    doc: Minimum depth (DP) of a variant (in all three samples).
    inputBinding:
      position: 101
      prefix: -var_min_dp
  - id: var_min_q
    type:
      - 'null'
      - float
    doc: Minimum quality (QUAL) of a variant.
    inputBinding:
      position: 101
      prefix: -var_min_q
outputs:
  - id: output_tsv
    type: File
    doc: Output TSV file containing the detected UPDs.
    outputBinding:
      glob: $(inputs.output_tsv)
  - id: output_informative
    type:
      - 'null'
      - File
    doc: Output IGV file containing informative variants.
    outputBinding:
      glob: $(inputs.output_informative)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
