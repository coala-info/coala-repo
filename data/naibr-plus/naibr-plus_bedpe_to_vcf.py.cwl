cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedpe_to_vcf.py
label: naibr-plus_bedpe_to_vcf.py
doc: "Convert NAIBR BEDPE files to VCF\n\nTool homepage: https://github.com/pontushojer/NAIBR"
inputs:
  - id: bedpe
    type: File
    doc: NAIBR-style BEDPE.
    inputBinding:
      position: 1
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: Prepend 'chr' to chromsome names
    inputBinding:
      position: 102
      prefix: --add-chr
  - id: ref
    type: string
    doc: List of chromosome lengths e.g. `*.fai`
    inputBinding:
      position: 102
      prefix: --ref
  - id: sample_name
    type:
      - 'null'
      - string
    doc: 'Sample name. Default: SAMPLE'
    inputBinding:
      position: 102
      prefix: --sample-name
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: 'Output VCF. Default: write to stdout'
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naibr-plus:0.5.3--pyhdfd78af_0
