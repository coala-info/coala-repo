cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - grpaf
label: truvari_anno_grpaf
doc: "Add allele frequency annotations for subsets of samples\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: output
    type:
      - 'null'
      - string
    default: grpaf.vcf
    doc: Output filename (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: labels
    type: File
    doc: Tab-delimited file of sample and group
    inputBinding:
      position: 1
      prefix: "-l"
  - id: tags
    type:
      - 'null'
      - string
    doc: Comma-separated list of tags to add from AF,MAF,ExcHet,HWE,MAC,AC,AN (all)
    inputBinding:
      position: 1
      prefix: "-t"
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Exit if sample listed in labels is not present in VCF (False)
    inputBinding:
      position: 1
      prefix: "--strict"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: input
    type: File
    doc: VCF to annotate
    inputBinding:
      position: 2
outputs:
  - id: output_vcf
    type: File
    doc: Annotated VCF
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
