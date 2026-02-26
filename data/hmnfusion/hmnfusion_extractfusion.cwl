cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnfusion
  - extractfusion
label: hmnfusion_extractfusion
doc: "Extract fusion information from Genefuse and Lumpy results\n\nTool homepage:
  https://github.com/guillaume-gricourt/HmnFusion"
inputs:
  - id: consensus_interval
    type:
      - 'null'
      - int
    doc: Interval, pb, for which Fusion are considered equal if their chrom are
    inputBinding:
      position: 101
      prefix: --consensus-interval
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
      prefix: --input-genefuse-json
  - id: input_hmnfusion_bed
    type:
      - 'null'
      - File
    doc: Bed file
    inputBinding:
      position: 101
      prefix: --input-hmnfusion-bed
  - id: input_lumpy_vcf
    type: File
    doc: Lumpy vcf file
    inputBinding:
      position: 101
      prefix: --input-lumpy-vcf
outputs:
  - id: output_hmnfusion_json
    type:
      - 'null'
      - File
    doc: Json file output
    outputBinding:
      glob: $(inputs.output_hmnfusion_json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
