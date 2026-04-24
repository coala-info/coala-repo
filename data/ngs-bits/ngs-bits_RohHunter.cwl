cwlVersion: v1.2
class: CommandLineTool
baseCommand: RohHunter
label: ngs-bits_RohHunter
doc: "ROH detection based on a variant list.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of BED files used for annotation. Each file adds a column to the 
      output file. The base filename is used as column name and 4th column of 
      the BED file is used as annotation value.
    inputBinding:
      position: 101
      prefix: -annotate
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug output
    inputBinding:
      position: 101
      prefix: -debug
  - id: exclude_regions
    type:
      - 'null'
      - type: array
        items: File
    doc: BED files with regions to exclude from ROH analysis. Regions where 
      variant calling is not possible should be removed (centromers, MQ=0 
      regions and large stretches of N bases).
    inputBinding:
      position: 101
      prefix: -exclude
  - id: ext_marker_perc
    type:
      - 'null'
      - float
    doc: Percentage of ROH markers that can be spanned when merging ROH regions.
    inputBinding:
      position: 101
      prefix: -ext_marker_perc
  - id: ext_max_het_perc
    type:
      - 'null'
      - float
    doc: Maximum percentage of heterozygous markers in ROH regions.
    inputBinding:
      position: 101
      prefix: -ext_max_het_perc
  - id: ext_size_perc
    type:
      - 'null'
      - float
    doc: Percentage of ROH size that can be spanned when merging ROH regions.
    inputBinding:
      position: 101
      prefix: -ext_size_perc
  - id: include_chrX
    type:
      - 'null'
      - boolean
    doc: Include chrX into the analysis. Excluded by default.
    inputBinding:
      position: 101
      prefix: -inc_chrx
  - id: input_vcf
    type: File
    doc: Input variant list in VCF format.
    inputBinding:
      position: 101
      prefix: -in
  - id: roh_min_markers
    type:
      - 'null'
      - int
    doc: Minimum marker count of output ROH regions.
    inputBinding:
      position: 101
      prefix: -roh_min_markers
  - id: roh_min_q
    type:
      - 'null'
      - float
    doc: Minimum Q score of output ROH regions.
    inputBinding:
      position: 101
      prefix: -roh_min_q
  - id: roh_min_size
    type:
      - 'null'
      - float
    doc: Minimum size in Kb of output ROH regions.
    inputBinding:
      position: 101
      prefix: -roh_min_size
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: var_af_keys
    type:
      - 'null'
      - string
    doc: Comma-separated allele frequency info field names in 'in'.
    inputBinding:
      position: 101
      prefix: -var_af_keys
  - id: var_af_keys_vep
    type:
      - 'null'
      - string
    doc: Comma-separated VEP CSQ field names of allele frequency annotations in 
      'in'.
    inputBinding:
      position: 101
      prefix: -var_af_keys_vep
  - id: var_min_dp
    type:
      - 'null'
      - int
    doc: Minimum variant depth ('DP'). Variants with lower depth are excluded 
      from the analysis.
    inputBinding:
      position: 101
      prefix: -var_min_dp
  - id: var_min_q
    type:
      - 'null'
      - float
    doc: Minimum variant quality. Variants with lower quality are excluded from 
      the analysis.
    inputBinding:
      position: 101
      prefix: -var_min_q
outputs:
  - id: output_tsv
    type: File
    doc: Output TSV file with ROH regions.
    outputBinding:
      glob: $(inputs.output_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
