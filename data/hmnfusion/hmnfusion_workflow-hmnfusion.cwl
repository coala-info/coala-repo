cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnfusion
  - workflow-hmnfusion
label: hmnfusion_workflow-hmnfusion
doc: "HmnFusion workflow for processing Lumpy and Genefuse results\n\nTool homepage:
  https://github.com/guillaume-gricourt/HmnFusion"
inputs:
  - id: input_genefuse_html
    type:
      - 'null'
      - File
    doc: Genefuse, html file
    inputBinding:
      position: 101
      prefix: --input-genefuse-html
  - id: input_genefuse_json
    type:
      - 'null'
      - File
    doc: Genefuse, json file
    inputBinding:
      position: 101
      prefix: --input-genefuse_json
  - id: input_hmnfusion_bed
    type:
      - 'null'
      - File
    doc: HmnFusion bed file
    inputBinding:
      position: 101
      prefix: --input-hmnfusion-bed
  - id: input_lumpy_vcf
    type: File
    doc: Lumpy Vcf file
    inputBinding:
      position: 101
      prefix: --input-lumpy-vcf
  - id: input_sample_bam
    type: File
    doc: Bam file
    inputBinding:
      position: 101
      prefix: --input-sample-bam
  - id: name
    type: string
    doc: Name of sample
    inputBinding:
      position: 101
      prefix: --name
outputs:
  - id: output_hmnfusion_vcf
    type: File
    doc: Vcf file output
    outputBinding:
      glob: $(inputs.output_hmnfusion_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
