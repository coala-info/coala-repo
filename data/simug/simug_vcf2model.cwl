cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2model
label: simug_vcf2model
doc: "vcf2model profiles the SNP and INDEL variants of a VCF file and writes SNP and
  INDEL model files that simuG can use to simulate similar variants.\n\nTool homepage:
  https://github.com/yjx1217/simuG"
inputs:
  - id: vcf
    type: File
    doc: "Input variant calling file (vcf or vcf.gz)."
    inputBinding:
      position: 1
      prefix: -vcf
  - id: excluded_chr_list
    type:
      - 'null'
      - File
    doc: "List of chromosome(s) to be excluded from variant profiling."
    inputBinding:
      position: 1
      prefix: -excluded_chr_list
  - id: qual
    type:
      - 'null'
      - float
    doc: "Cutoff of the minimal variant quality to be considered (default 0)."
    inputBinding:
      position: 1
      prefix: -qual
  - id: prefix
    type:
      - 'null'
      - string
    doc: "File name prefix for the output files (default: output_prefix)."
    inputBinding:
      position: 1
      prefix: -prefix
outputs:
  - id: model_files
    type:
      type: array
      items: File
    doc: SNP and INDEL model files written with the prefix
    outputBinding:
      glob: '$(inputs.prefix ? inputs.prefix : "output_prefix")*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simug:1.0.1--hdfd78af_0
