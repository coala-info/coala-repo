cwlVersion: v1.2
class: CommandLineTool
baseCommand: varextract
label: mimodd_varextract
doc: "Extracts variant sites from BCF files.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: input_file
    type: File
    doc: BCF output from varcall
    inputBinding:
      position: 1
  - id: keep_alts
    type:
      - 'null'
      - boolean
    doc: keep all alternate allele candidates even if they do not appear in any 
      genotype
    inputBinding:
      position: 102
      prefix: --keep-alts
  - id: pre_vcf
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 102
      prefix: --pre-vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output (variant sites) to the specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
