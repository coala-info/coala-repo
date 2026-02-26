cwlVersion: v1.2
class: CommandLineTool
baseCommand: delly filter
label: delly_filter
doc: "Filter SV calls in a BCF file\n\nTool homepage: https://github.com/dellytools/delly"
inputs:
  - id: input_bcf
    type: File
    doc: Input BCF file
    inputBinding:
      position: 1
  - id: filter_mode
    type:
      - 'null'
      - string
    doc: Filter mode (somatic, germline)
    default: somatic
    inputBinding:
      position: 102
      prefix: --filter
  - id: filter_pass_sites
    type:
      - 'null'
      - boolean
    doc: Filter sites for PASS
    inputBinding:
      position: 102
      prefix: --pass
  - id: max_control_alt_support
    type:
      - 'null'
      - float
    doc: max. fractional ALT support in control
    default: 0
    inputBinding:
      position: 102
      prefix: --controlcontamination
  - id: max_deletion_read_depth_ratio
    type:
      - 'null'
      - float
    doc: max. read-depth ratio of carrier vs. non-carrier for a deletion
    default: 0.800000012
    inputBinding:
      position: 102
      prefix: --rddel
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: max. SV size
    default: 500000000
    inputBinding:
      position: 102
      prefix: --maxsize
  - id: min_duplication_read_depth_ratio
    type:
      - 'null'
      - float
    doc: min. read-depth ratio of carrier vs. non-carrier for a duplication
    default: 1.20000005
    inputBinding:
      position: 102
      prefix: --rddup
  - id: min_fraction_genotyped_samples
    type:
      - 'null'
      - float
    doc: min. fraction of genotyped samples
    default: 0.75
    inputBinding:
      position: 102
      prefix: --ratiogeno
  - id: min_fractional_alt_support
    type:
      - 'null'
      - float
    doc: min. fractional ALT support
    default: 0.0299999993
    inputBinding:
      position: 102
      prefix: --altaf
  - id: min_median_gq
    type:
      - 'null'
      - int
    doc: min. median GQ for carriers and non-carriers
    default: 15
    inputBinding:
      position: 102
      prefix: --gq
  - id: min_sv_site_quality
    type:
      - 'null'
      - int
    doc: min. SV site quality
    default: 300
    inputBinding:
      position: 102
      prefix: --quality
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: min. SV size
    default: 0
    inputBinding:
      position: 102
      prefix: --minsize
  - id: min_tumor_coverage
    type:
      - 'null'
      - int
    doc: min. coverage in tumor
    default: 10
    inputBinding:
      position: 102
      prefix: --coverage
  - id: somatic_samples_file
    type:
      - 'null'
      - File
    doc: Two-column sample file listing sample name and tumor or control
    inputBinding:
      position: 102
      prefix: --samples
  - id: tag_filtered_sites
    type:
      - 'null'
      - boolean
    doc: Tag filtered sites in the FILTER column instead of removing them
    inputBinding:
      position: 102
      prefix: --tag
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Filtered SV BCF output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/delly:1.7.2--h4d20210_0
