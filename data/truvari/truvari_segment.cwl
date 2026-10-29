cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - segment
label: truvari_segment
doc: "Segmentation: Normalization of SVs into disjointed genomic regions\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: output
    type:
      - 'null'
      - string
    default: segment.vcf
    doc: Output VCF
    inputBinding:
      position: 1
      prefix: "-o"
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: Only segment PASS variants
    inputBinding:
      position: 1
      prefix: "--passonly"
  - id: input
    type: File
    doc: VCF to parse
    inputBinding:
      position: 2
outputs:
  - id: output_vcf
    type: File
    doc: Segmented VCF
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
