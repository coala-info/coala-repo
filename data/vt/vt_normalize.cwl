cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt normalize
label: vt_normalize
doc: "normalizes variants in a VCF file\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug
    default: false
    inputBinding:
      position: 102
      prefix: -d
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    default: ''
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
  - id: no_fail_on_ref_mismatch
    type:
      - 'null'
      - boolean
    doc: do not fail when REF is inconsistent with reference sequence for non 
      SNPs
    default: false
    inputBinding:
      position: 102
      prefix: -n
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: do not print options and summary
    default: false
    inputBinding:
      position: 102
      prefix: -q
  - id: reference_fasta
    type: File
    doc: reference sequence fasta file
    inputBinding:
      position: 102
      prefix: -r
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size for local sorting of variants
    default: 10000
    inputBinding:
      position: 102
      prefix: -w
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
