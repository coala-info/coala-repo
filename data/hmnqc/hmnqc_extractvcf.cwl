cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnqc
  - extractvcf
label: hmnqc_extractvcf
doc: "Extract VAF or SNP information from VCF files into an Excel output\n\nTool homepage:
  https://github.com/guillaume-gricourt/HmnQc"
inputs:
  - id: input_reference_vcf
    type: File
    doc: Vcf file with SNPs to extract
    inputBinding:
      position: 101
      prefix: --input-reference-vcf
  - id: input_sample_vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: Vcf files
    inputBinding:
      position: 101
      prefix: --input-sample-vcf
  - id: parameter_mode
    type:
      - 'null'
      - string
    doc: Which information to extract (snp or vaf)
    inputBinding:
      position: 101
      prefix: --parameter-mode
  - id: parameter_variant_caller
    type:
      - 'null'
      - string
    doc: From which caller VCF samples are created (ls or hc)
    inputBinding:
      position: 101
      prefix: --parameter-variant-caller
  - id: output_hmnqc_xlsx_path
    type: string
    doc: Output or path parameter `output_hmnqc_xlsx_path`
    inputBinding:
      position: 102
      prefix: --output-hmnqc-xlsx
outputs:
  - id: output_hmnqc_xlsx
    type: File
    doc: Excel output
    outputBinding:
      glob: $(inputs.output_hmnqc_xlsx_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
