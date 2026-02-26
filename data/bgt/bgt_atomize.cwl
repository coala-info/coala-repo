cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bgt
  - atomize
label: bgt_atomize
doc: "Atomize a VCF/BCF file\n\nTool homepage: https://github.com/Dysman/bgTools-playerPrefsEditor"
inputs:
  - id: input_file
    type: File
    doc: Input BCF or VCF file
    inputBinding:
      position: 1
  - id: bcf_output
    type:
      - 'null'
      - boolean
    doc: BCF output
    inputBinding:
      position: 102
      prefix: -b
  - id: contig_lengths_file
    type:
      - 'null'
      - File
    doc: list of contig names and lengths (force -S)
    inputBinding:
      position: 102
      prefix: -t
  - id: use_0_at_multiallelic
    type:
      - 'null'
      - boolean
    doc: use 0 at a multi-allelic genotype
    inputBinding:
      position: 102
      prefix: '-0'
  - id: use_m_at_multiallelic
    type:
      - 'null'
      - boolean
    doc: use <M> at a multi-allelic site (override -0)
    inputBinding:
      position: 102
      prefix: -M
  - id: vcf_input
    type:
      - 'null'
      - boolean
    doc: VCF input
    inputBinding:
      position: 102
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgt:r283--h577a1d6_7
stdout: bgt_atomize.out
