cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt_cat
label: vt_cat
doc: "Concatenate VCF files. Individuals must be in the same order.\n\nTool homepage:
  https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcfs
    type:
      type: array
      items: File
    doc: Input VCF files
    inputBinding:
      position: 1
  - id: filter_expression
    type:
      - 'null'
      - string
    doc: filter expression
    default: ''
    inputBinding:
      position: 102
      prefix: -f
  - id: input_vcf_list_file
    type:
      - 'null'
      - File
    doc: file containing list of input VCF files
    inputBinding:
      position: 102
      prefix: -L
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    inputBinding:
      position: 102
      prefix: -i
  - id: intervals_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    default: ''
    inputBinding:
      position: 102
      prefix: -I
  - id: naive
    type:
      - 'null'
      - boolean
    doc: naive, assumes that headers are the same.
    default: false
    inputBinding:
      position: 102
      prefix: -n
  - id: print_options_and_summary
    type:
      - 'null'
      - boolean
    doc: print options and summary
    default: false
    inputBinding:
      position: 102
      prefix: -p
  - id: site_info_only
    type:
      - 'null'
      - boolean
    doc: print site information only without genotypes
    default: false
    inputBinding:
      position: 102
      prefix: -s
  - id: sorting_window_size
    type:
      - 'null'
      - int
    doc: local sorting window size
    default: 0
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: output_vcf_file
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
