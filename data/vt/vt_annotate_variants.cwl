cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt_annotate_variants
label: vt_annotate_variants
doc: "annotates variants in a VCF file\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: in_vcf
    type: File
    doc: input VCF file
    inputBinding:
      position: 1
  - id: coding_regions_bed
    type:
      - 'null'
      - File
    doc: coding regions BED file
    default: '[]'
    inputBinding:
      position: 102
      prefix: -g
  - id: filter_expression
    type:
      - 'null'
      - string
    doc: filter expression
    default: '[]'
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
  - id: intervals_list_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    default: '[]'
    inputBinding:
      position: 102
      prefix: -I
  - id: low_complexity_regions_bed
    type:
      - 'null'
      - File
    doc: low complexity regions BED file
    default: '[]'
    inputBinding:
      position: 102
      prefix: -m
  - id: reference_fasta
    type: File
    doc: reference sequence fasta file
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
