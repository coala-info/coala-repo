cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vt
  - compute_concordance
label: vt_compute_concordance
doc: "Compute Concordance.\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: in1_vcf
    type: File
    doc: First input VCF file
    inputBinding:
      position: 1
  - id: in2_vcf
    type: File
    doc: Second input VCF file
    inputBinding:
      position: 2
  - id: filter_expression
    type:
      - 'null'
      - string
    doc: filter expression
    inputBinding:
      position: 103
      prefix: -f
  - id: intervals
    type:
      - 'null'
      - string
    doc: Intervals
    default: ''
    inputBinding:
      position: 103
      prefix: -i
  - id: intervals_list_file
    type:
      - 'null'
      - File
    doc: File containing list of intervals
    default: ''
    inputBinding:
      position: 103
      prefix: -I
  - id: sample_concordance_file
    type:
      - 'null'
      - File
    doc: Sample concordance text file
    default: s.txt
    inputBinding:
      position: 103
      prefix: -s
  - id: variant_concordance_file
    type:
      - 'null'
      - File
    doc: Variant concordance text file
    default: m.txt
    inputBinding:
      position: 103
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
stdout: vt_compute_concordance.out
