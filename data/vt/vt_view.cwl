cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt_view
label: vt_view
doc: "Views a VCF or BCF or VCF.GZ file.\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF/BCF/VCF.GZ file
    inputBinding:
      position: 1
  - id: filter_expression
    type:
      - 'null'
      - string
    doc: filter expression
    inputBinding:
      position: 102
      prefix: -f
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
    inputBinding:
      position: 102
      prefix: -I
  - id: omit_header
    type:
      - 'null'
      - boolean
    doc: omit header, this option is honored only for STDOUT
    default: false
    inputBinding:
      position: 102
      prefix: -h
  - id: print_header_only
    type:
      - 'null'
      - boolean
    doc: print header only, this option is honored only for STDOUT
    default: false
    inputBinding:
      position: 102
      prefix: -H
  - id: print_options_and_summary
    type:
      - 'null'
      - boolean
    doc: print options and summary
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
  - id: output_file
    type:
      - 'null'
      - File
    doc: output VCF/VCF.GZ/BCF file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
