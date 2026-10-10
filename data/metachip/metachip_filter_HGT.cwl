cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MetaCHIP
  - filter_HGT
label: metachip_filter_HGT
doc: "Get HGTs detected at least n taxonomic levels from a multi-level MetaCHIP
  result.\n\nTool homepage: https://github.com/songweizhi/MetaCHIP"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hgt_file)
        writable: true
      - entry: $(inputs.ffn_file)
        writable: true
      - entry: $(inputs.faa_file)
        writable: true
inputs:
  - id: hgt_file
    type: File
    doc: txt file containing detected HGTs, e.g. [prefix]_[ranks]_detected_HGTs.txt
    inputBinding:
      prefix: -i
  - id: min_levels
    type: int
    doc: HGTs detected at least n levels, 2 <= n <= 5
    inputBinding:
      prefix: -n
  - id: ffn_file
    type: ['null', File]
    doc: get nucleotide sequences for qualified HGTs
    inputBinding:
      prefix: -ffn
  - id: faa_file
    type: ['null', File]
    doc: get amino acid sequences for qualified HGTs
    inputBinding:
      prefix: -faa
outputs:
  - id: filtered_hgts
    type: File
    doc: filtered HGT table, [input basename]_min_level_num_[n].txt
    outputBinding:
      glob: "$(inputs.hgt_file.nameroot)_min_level_num_$(inputs.min_levels)$(inputs.hgt_file.nameext)"
  - id: qualified_ffn
    type: ['null', File]
    doc: nucleotide sequences of qualified recipient genes
    outputBinding:
      glob: "$(inputs.ffn_file ? inputs.ffn_file.nameroot + '_min_level_num_' + inputs.min_levels + '.ffn' : null)"
  - id: qualified_faa
    type: ['null', File]
    doc: amino acid sequences of qualified recipient genes
    outputBinding:
      glob: "$(inputs.faa_file ? inputs.faa_file.nameroot + '_min_level_num_' + inputs.min_levels + '.faa' : null)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
