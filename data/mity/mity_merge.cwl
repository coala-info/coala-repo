cwlVersion: v1.2
class: CommandLineTool
baseCommand: mity_merge
label: mity_merge
doc: "Merge MITY and nuclear VCF files.\n\nTool homepage: https://github.com/KCCG/mity"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enter debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate files
    inputBinding:
      position: 101
      prefix: --keep
  - id: mity_vcf
    type: File
    doc: mity vcf file
    inputBinding:
      position: 101
      prefix: --mity_vcf
  - id: nuclear_vcf
    type: File
    doc: nuclear vcf file
    inputBinding:
      position: 101
      prefix: --nuclear_vcf
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output files will be saved in OUTPUT_DIR.
    default: .
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output files will be named with PREFIX. The default is to use the 
      nuclear vcf name
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - string
    doc: reference genome version to use.
    default: hs37d5
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
stdout: mity_merge.out
