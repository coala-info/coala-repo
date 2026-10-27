cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vt
  - compute_concordance
label: vt_compute_concordance
doc: "Compute Concordance.\n\nTool homepage: https://github.com/atks/vt"
inputs:
  - id: in1_vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
    doc: First input VCF file
    inputBinding:
      position: 1
  - id: in2_vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
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
    inputBinding:
      position: 103
      prefix: -i
  - id: intervals_list_file
    type:
      - 'null'
      - File
    doc: File containing list of intervals
    inputBinding:
      position: 103
      prefix: -I
  - id: sample_concordance_file
    type:
      - 'null'
      - string
    doc: Sample concordance text file
    inputBinding:
      position: 103
      prefix: -s
  - id: variant_concordance_file
    type:
      - 'null'
      - string
    doc: Variant concordance text file
    inputBinding:
      position: 103
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: summary
    type: stderr
    doc: Run summary (vt writes it to standard error)
  - id: sample_concordance
    type:
      - 'null'
      - File
    doc: Sample concordance text file (default s.txt)
    outputBinding:
      glob: "$(inputs.sample_concordance_file ? inputs.sample_concordance_file : 's.txt')"
  - id: variant_concordance
    type:
      - 'null'
      - File
    doc: Variant concordance text file (default m.txt)
    outputBinding:
      glob: "$(inputs.variant_concordance_file ? inputs.variant_concordance_file : 'm.txt')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
stdout: vt_compute_concordance.out
stderr: vt_compute_concordance.err
