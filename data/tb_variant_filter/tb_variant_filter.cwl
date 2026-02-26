cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb_variant_filter
label: tb_variant_filter
doc: "Filter variants from a VCF file (relative to M. tuberculosis H37Rv)\n\nTool
  homepage: http://github.com/pvanheus/tb_variant_filter"
inputs:
  - id: input_file
    type: File
    doc: VCF input file (relative to H37Rv)
    inputBinding:
      position: 1
  - id: close_to_indel_filter
    type:
      - 'null'
      - boolean
    doc: Mask out single nucleotide variants that are too close to indels
    inputBinding:
      position: 102
      prefix: --close_to_indel_filter
  - id: indel_window_size
    type:
      - 'null'
      - int
    doc: Window around indel to mask out (mask this number of bases 
      upstream/downstream from the indel. Requires -I option to selected)
    inputBinding:
      position: 102
      prefix: --indel_window_size
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Variants at sites with less than this depth of reads will be masked out
    inputBinding:
      position: 102
      prefix: --min_depth
  - id: min_depth_filter
    type:
      - 'null'
      - boolean
    doc: Mask out variants with less than a given depth of reads
    inputBinding:
      position: 102
      prefix: --min_depth_filter
  - id: min_percentage_alt
    type:
      - 'null'
      - float
    doc: Variants with less than this percentage variants at a site will be 
      masked out
    inputBinding:
      position: 102
      prefix: --min_percentage_alt
  - id: min_percentage_alt_filter
    type:
      - 'null'
      - boolean
    doc: Mask out variants with less than a given percentage variant allele at 
      this site
    inputBinding:
      position: 102
      prefix: --min_percentage_alt_filter
  - id: region_filter
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --region_filter
  - id: snv_only_filter
    type:
      - 'null'
      - boolean
    doc: Mask out variants that are not SNVs
    inputBinding:
      position: 102
      prefix: --snv_only_filter
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file (VCF format)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb_variant_filter:0.4.0--pyhdfd78af_0
