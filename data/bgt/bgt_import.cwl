cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bgt
  - import
label: bgt_import
doc: "Import VCF/BCF files into BGT format\n\nTool homepage: https://github.com/lh3/bgt"
inputs:
  - id: out_prefix
    type: string
    doc: Output prefix for BGT files
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input BCF or VCF file
    inputBinding:
      position: 2
  - id: generate_pb1
    type:
      - 'null'
      - boolean
    doc: generate .pb1 file (not used for now)
    inputBinding:
      position: 103
      prefix: '-1'
  - id: input_is_vcf
    type:
      - 'null'
      - boolean
    doc: input is VCF
    inputBinding:
      position: 103
      prefix: -S
  - id: keep_filtered
    type:
      - 'null'
      - boolean
    doc: keep filtered variants
    inputBinding:
      position: 103
      prefix: -F
  - id: reference_list
    type:
      - 'null'
      - File
    doc: list of reference names and lengths
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in out_prefix
    outputBinding:
      glob: $(inputs.out_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgt:r283--h577a1d6_7
stdout: bgt_import.out
