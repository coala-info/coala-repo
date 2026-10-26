cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiallelics-filter
label: vafator_multiallelics-filter
doc: "Filter multiallelic variants of a VAFator annotated VCF, using the tumor allele frequency annotation.\n\nTool homepage: https://github.com/tron-bioinformatics/vafator"
inputs:
  - id: input_vcf
    type: File
    doc: The VCF to annotate
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: output_vcf_path
    type: string
    doc: The annotated VCF
    inputBinding:
      position: 102
      prefix: --output-vcf
  - id: tumor_sample_name
    type:
      - 'null'
      - string
    doc: The tumor sample name (will look for annotation ${SAMPLE_NAME}_af) [tumor]
    inputBinding:
      position: 103
      prefix: --tumor-sample-name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_vcf
    type: File
    doc: The filtered VCF
    outputBinding:
      glob: $(inputs.output_vcf_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vafator:2.2.2--pyhdfd78af_0
stdout: vafator_multiallelics-filter.out
